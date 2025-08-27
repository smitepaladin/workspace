//
//  RoutesListView.swift
//  running
//
//  Created by Jun Jong Eck on 8/21/25.
//
// RoutesListView.swift
import SwiftUI
import CoreLocation
import FirebaseFirestore
import FirebaseAuth

struct FireRoute: Identifiable, Hashable, Equatable {
    var id: String
    var createdAt: Date
    var createdBy: String
    var desc: String
    var expectedTimeMin: Int
    var coords: [CLLocationCoordinate2D]
    var distanceM: Double {
        guard coords.count > 1 else { return 0 }
        var sum = 0.0
        for i in 1..<coords.count {
            let a = CLLocation(latitude: coords[i-1].latitude, longitude: coords[i-1].longitude)
            let b = CLLocation(latitude: coords[i].latitude,  longitude: coords[i].longitude)
            sum += a.distance(from: b)
        }
        return sum
    }
    static func == (lhs: FireRoute, rhs: FireRoute) -> Bool { lhs.id == rhs.id }
    func hash(into hasher: inout Hasher) { hasher.combine(id) }
}

final class RoutesVM: ObservableObject {
    @Published var routes: [FireRoute] = []
    @Published var loading = false
    @Published var error: String?

    private let db = Firestore.firestore()

    enum Tab { case my, together }

    func load(tab: Tab) async {
        await MainActor.run { loading = true; error = nil }
        defer { Task { @MainActor in self.loading = false } }

        guard let email = Auth.auth().currentUser?.email else {
            await MainActor.run { self.error = "로그인이 필요합니다." }
            return
        }

        do {
            let items: [FireRoute]
            switch tab {
            case .my:
                items = try await fetchMy(email: email)
            case .together:
                items = try await fetchOthers(notEmail: email)
            }
            await MainActor.run { self.routes = items.sorted(by: { $0.createdAt > $1.createdAt }) }
        } catch {
            await MainActor.run { self.error = error.localizedDescription }
        }
    }

    // MARK: Queries
    private func fetchMy(email: String) async throws -> [FireRoute] {
        let snap = try await db.collection("routes")
            .whereField("createdBy", isEqualTo: email)
            .getDocuments()

        let items = snap.documents.compactMap(decodeRoute(_:))
        return items.sorted { $0.createdAt > $1.createdAt }
    }

    // Firestore는 != 에 제약이 있으므로 `< email` + `> email` 두 번 쿼리해서 합칩니다.
    private func fetchOthers(notEmail email: String) async throws -> [FireRoute] {
        async let lower = db.collection("routes")
            .whereField("createdBy", isLessThan: email)
            .order(by: "createdBy")
            .getDocuments()

        async let upper = db.collection("routes")
            .whereField("createdBy", isGreaterThan: email)
            .order(by: "createdBy")
            .getDocuments()

        let (lSnap, uSnap) = try await (lower, upper)
        let l = lSnap.documents.compactMap(decodeRoute(_:))
        let u = uSnap.documents.compactMap(decodeRoute(_:))
        return l + u
    }

    // MARK: Decoder
    private func decodeRoute(_ doc: DocumentSnapshot) -> FireRoute? {
        guard let d = doc.data() else { return nil }
        let createdAt = (d["createdAt"] as? Timestamp)?.dateValue() ?? Date()
        let createdBy = d["createdBy"] as? String ?? ""
        let desc      = d["description"] as? String ?? ""
        let expected  = d["expectedTime"] as? Int ?? 0

        // path가 [GeoPoint] 인 경우/ 숫자쌍 배열인 경우 모두 지원
        var coords: [CLLocationCoordinate2D] = []
        if let gps = d["path"] as? [GeoPoint] {
            coords = gps.map { .init(latitude: $0.latitude, longitude: $0.longitude) }
        } else if let raw = d["path"] as? [[Double]] {
            coords = raw.compactMap { $0.count == 2 ? .init(latitude: $0[0], longitude: $0[1]) : nil }
        }
        return FireRoute(id: doc.documentID,
                         createdAt: createdAt,
                         createdBy: createdBy,
                         desc: desc,
                         expectedTimeMin: expected,
                         coords: coords)
    }
}

struct RoutesListView: View {
    @StateObject private var vm = RoutesVM()
    @State private var tab: RoutesVM.Tab = .my
    @State private var showCreate = false

    var body: some View {
        NavigationStack {
            ZStack {
                if vm.loading && vm.routes.isEmpty { ProgressView().controlSize(.large) }
                else if let err = vm.error, vm.routes.isEmpty {
                    VStack(spacing: 8) {
                        Text("불러오기 오류")
                        Text(err).font(.footnote).foregroundStyle(.secondary)
                        Button("다시 시도") { Task { await vm.load(tab: tab) } }.buttonStyle(.bordered)
                    }
                } else {
                    List(vm.routes) { RouteRow(route: $0) }
                        .listStyle(.plain)
                        .refreshable { await vm.load(tab: tab) }
                }
            }
            .navigationTitle("Share")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button { showCreate = true } label: { Image(systemName: "plus").font(.title3.bold()) }
                }
            }
            .safeAreaInset(edge: .top) {
                HStack(spacing: 24) {
                    Button {
                        tab = .my
                        Task { await vm.load(tab: .my) }
                    } label: {
                        Text("my").fontWeight(tab == .my ? .semibold : .regular)
                            .foregroundStyle(tab == .my ? .indigo : .secondary)
                    }
                    Button {
                        tab = .together
                        Task { await vm.load(tab: .together) }
                    } label: {
                        Text("together").foregroundStyle(tab == .together ? .indigo : .secondary)
                    }
                    Spacer()
                }
                .padding(.horizontal, 20).padding(.vertical, 8)
                .background(.ultraThinMaterial)
            }
            .sheet(isPresented: $showCreate, onDismiss: { Task { await vm.load(tab: tab) } }) {
                CreateRouteView()
            }
        }
        .task { await vm.load(tab: tab) }
    }
}

// 그대로 사용
private struct RouteRow: View {
    let route: FireRoute
    var body: some View {
        HStack(spacing: 14) {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.primary.opacity(0.06))
                .frame(width: 50, height: 50)
                .overlay(Image(systemName: "mappin.and.ellipse").font(.system(size: 22, weight: .semibold)))
            VStack(alignment: .leading, spacing: 4) {
                Text(dateTitle(route.createdAt)).font(.body.weight(.semibold))
                Text("\(formatDistance(route.distanceM)) · \(route.expectedTimeMin) min")
                    .font(.subheadline).foregroundStyle(.secondary)
                if !route.desc.isEmpty { Text(route.desc).font(.footnote).foregroundStyle(.secondary) }
            }
            Spacer()
        }
        .padding(.vertical, 6)
    }
    private func dateTitle(_ d: Date) -> String {
        let c = Calendar.current
        if c.isDateInToday(d) { return "Today, " + timeString(d) }
        if c.isDateInYesterday(d) { return "Yesterday, " + timeString(d) }
        let f = DateFormatter(); f.dateFormat = "MMM d, h:mm a"; return f.string(from: d)
    }
    private func timeString(_ d: Date) -> String { let f = DateFormatter(); f.dateFormat = "h:mm a"; return f.string(from: d) }
    private func formatDistance(_ m: Double) -> String { String(format: "%.1f km", m/1000.0) }
}

#Preview {
    RoutesListView()
}
