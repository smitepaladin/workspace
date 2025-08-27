//
//  UserViewModel.swift
//  hangang
//
//  Created by Jun Jong Eck on 8/19/25.
//

// VM/UserViewModel.swift
import Foundation

@MainActor
final class UserViewModel: ObservableObject {
    @Published var user: User? = nil
    @Published var idToken: String? = nil
    @Published var isLoading = false
    @Published var errorMessage: String? = nil

    // 시뮬레이터: 127.0.0.1, 실기기: 맥 로컬 IP
    private let baseURL = URL(string: "http://127.0.0.1:8000")!

    // MARK: - Join (백엔드 형식 유지)
    func join(email: String, password: String, name: String) async {
        clearError(); isLoading = true; defer { isLoading = false }

        struct Body: Codable { let email: String; let password: String; let name: String }
        do {
            let res: JoinResponse = try await post("/join", body: Body(email: email, password: password, name: name))
            if let u = res.user {
                self.user = u
            } else if let msg = res.msg {
                throw SimpleError(msg)
            } else {
                throw SimpleError("회원가입 응답을 해석할 수 없습니다.")
            }
        } catch { errorMessage = niceError(error) }
    }

    // MARK: - Login (백엔드 형식 유지)
    func login(email: String, password: String) async {
        clearError(); isLoading = true; defer { isLoading = false }

        struct Body: Codable { let email: String; let password: String }
        do {
            let res: LoginResponse = try await post("/login", body: Body(email: email, password: password))

            if let token = res.idToken { self.idToken = token }
            if let u = res.user     { self.user = u }

            if self.user == nil && res.msg != nil {
                throw SimpleError(res.msg!)
            }
            if self.user == nil && self.idToken == nil {
                throw SimpleError("로그인 응답을 해석할 수 없습니다.")
            }
        } catch { errorMessage = niceError(error) }
    }

    func logout() {
        user = nil
        idToken = nil
    }

    // MARK: - Networking (공통)
    private func post<T: Codable, R: Codable>(_ path: String, body: T) async throws -> R {
        var req = URLRequest(url: baseURL.appendingPathComponent(path))
        req.httpMethod = "POST"
        req.addValue("application/json", forHTTPHeaderField: "Content-Type")
        req.httpBody = try JSONEncoder().encode(body)

        let (data, response) = try await URLSession.shared.data(for: req)
        guard let http = response as? HTTPURLResponse else { throw URLError(.badServerResponse) }

        // 백엔드가 오류 시 { "msg": "..."}만 보내도 잡히게
        guard (200..<300).contains(http.statusCode) else {
            if let apiErr = try? JSONDecoder().decode(JoinResponse.self, from: data), let m = apiErr.msg {
                throw SimpleError(m)
            }
            if let apiErr = try? JSONDecoder().decode(LoginResponse.self, from: data), let m = apiErr.msg {
                throw SimpleError(m)
            }
            throw URLError(.badServerResponse)
        }
        return try JSONDecoder().decode(R.self, from: data)
    }

    private func clearError() { errorMessage = nil }
    private func niceError(_ error: Error) -> String { (error as? SimpleError)?.message ?? "오류: \(error.localizedDescription)" }
}

struct SimpleError: LocalizedError { let message: String; var errorDescription: String? { message } }
