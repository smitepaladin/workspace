//
//  SignUpViewModel.swift
//  running
//
//  Created by Jun Jong Eck on 8/20/25.
//
import Foundation
import FirebaseAuth              // Firebase Auth (회원가입, 로그인 등) 기능 사용
import FirebaseFirestore         // Firestore 데이터베이스 기능 사용
import FirebaseStorage           // 업로드용


@MainActor                       // UI 업데이트는 메인 스레드에서만 실행하도록 지정
final class SignUpViewModel: ObservableObject { // ViewModel: SwiftUI와 데이터 바인딩

    // 사용자 입력값 (화면에서 바인딩할 변수들)
    @Published var name: String = ""            // 이름 입력
    @Published var email: String = ""           // 이메일 입력
    @Published var password: String = ""        // 비밀번호 입력
    @Published var confirmPassword: String = "" // 비밀번호 확인 입력
    @Published var hasCar: Bool = false         // 차 보유 여부 토글
    @Published var hasChildren: Bool = false    // 자녀 유무 토글
    
    // 주민번호 앞 7자리 입력 (모델 UserProfile의 identification 필드와 매칭)
    @Published var identification: String = ""

    // 이메일 중복 확인 상태 관리
    @Published var isCheckingEmail: Bool = false // 중복 확인 중이면 true → 버튼 로딩 표시
    @Published var isEmailAvailable: Bool? = nil // 사용 가능 여부(nil=아직 체크 안 함)
    
    // 프로퍼티 추가
    @Published var heightText: String = ""
    @Published var weightText: String = ""
    @Published var profileImageData: Data? = nil

    // UI 상태 관리
    @Published var isLoading: Bool = false      // 회원가입 진행 중 로딩 상태
    @Published var alertMessage: String?        // 알림창에 띄울 메시지
    @Published var didCompleteSignUp: Bool = false // 회원가입 완료 여부
    @Published var createdProfile: UserProfile? // 성공 시 생성된 프로필 객체 저장

    // ----------------- 회원가입 로직 -----------------
    func signUp() async {
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty else { return show("이름을 입력해주세요.") }
        guard isValidEmail(email) else { return show("올바른 이메일을 입력해주세요.") }
        guard password.count >= 6 else { return show("비밀번호는 6자 이상이어야 합니다.") }
        guard password == confirmPassword else { return show("비밀번호가 일치하지 않습니다.") }
        guard isValidRRN7(identification) else { return show("주민번호를 정확하게 입력해주세요.") }

        isLoading = true
        defer { isLoading = false }

        do {
            // 1) Auth 계정 생성
            let result = try await Auth.auth().createUser(withEmail: email, password: password)

            // 2) displayName 저장
            let change = result.user.createProfileChangeRequest()
            change.displayName = name
            try await change.commitChanges()

            // 3) (선택) 사진 업로드 → URL 획득
            var photoURL: String? = nil
            if let data = profileImageData {
                let ref = Storage.storage().reference().child("profile_photos/\(result.user.uid).jpg")
                let meta = StorageMetadata(); meta.contentType = "application/octet-stream"
                _ = try await ref.putDataAsync(data, metadata: meta)
                photoURL = try await ref.downloadURL().absoluteString
            }

            // 4) 키/몸무게 파싱
            let heightVal = Double(heightText.replacingOccurrences(of: ",", with: "."))
            let weightVal = Double(weightText.replacingOccurrences(of: ",", with: "."))

            // 5) Firestore 문서 payload 구성 (선택값만 포함)
            var doc: [String: Any] = [
                "uid": result.user.uid,
                "name": name,
                "email": (result.user.email ?? email).lowercased(),
                "identification": identification,
                "isEmailVerified": result.user.isEmailVerified,
                "createdAt": Date(),        // ✅ 로컬 시간
                "hasCar": hasCar,
                "hasChildren": hasChildren
            ]
            if let h = heightVal { doc["heightCm"] = h }
            if let w = weightVal { doc["weightKg"] = w }
            if let url = photoURL { doc["imageAddress"] = url }

            // 6) 저장
            try await Firestore.firestore()
                .collection("user")
                .document(result.user.uid)
                .setData(doc, merge: true)

            // 7) VM용 프로필 객체 구성
            let profile = UserProfile(
                user: result.user,
                name: name,
                identification: identification,
                hasCar: hasCar,
                hasChildren: hasChildren,
                heightCm: heightVal,
                weightKg: weightVal,
                imageAddress: photoURL
            )
            createdProfile = profile
            didCompleteSignUp = true
            show("회원가입이 완료되었습니다.")
        } catch {
            let ns = error as NSError
            print("❌ signUp error:", ns.domain, ns.code, ns.userInfo)
            show(mapFirebaseError(error))
        }
    }
    
    // 비밀번호 규칙 검증 함수 (소문자+숫자+특수문자 포함, 6자리 이상)
    func isPasswordValid(_ password: String) -> Bool {
        let regex = "^(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$%^&*()_+=-]).{6,}$" // SQL injection 공격을 막기 위한 정규식
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: password)
    }

    // 이메일 정규식 검증 함수
    private func isValidEmail(_ s: String) -> Bool {
        let regex = #"^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$"# // SQL injection 공격을 막기 위한 정규식
        return s.range(of: regex, options: [.regularExpression, .caseInsensitive]) != nil
    }

    // 알림 메시지 표시 (공용 함수)
    private func show(_ message: String) { alertMessage = message }

    // Firebase 오류코드를 사용자 친화적 메시지로 변환
    private func mapFirebaseError(_ error: Error) -> String {
        let ns = error as NSError
        if let code = AuthErrorCode(rawValue: ns.code) {
            switch code {
            case .emailAlreadyInUse: return "이미 사용 중인 이메일입니다."
            case .invalidEmail: return "유효하지 않은 이메일입니다."
            case .weakPassword: return "비밀번호가 너무 약합니다."
            default: break
            }
        }
        return ns.localizedDescription
    }
    
    // 주민번호 앞 7자리 검증 함수
    private func isValidRRN7(_ s: String) -> Bool {
        let trimmed = s.trimmingCharacters(in: .whitespacesAndNewlines)
        guard trimmed.count == 7, trimmed.allSatisfy({ $0.isNumber }) else { return false }
        
        // YYMMDD 부분 유효성 검사
        let yy = Int(trimmed.prefix(2)) ?? -1
        let mm = Int(trimmed.dropFirst(2).prefix(2)) ?? -1
        let dd = Int(trimmed.dropFirst(4).prefix(2)) ?? -1
        
        guard (0...99).contains(yy), (1...12).contains(mm), (1...31).contains(dd) else { return false }
        return true
    }
    
    // ----------------- 이메일 중복 확인 -----------------
    func checkEmailDuplicate() async {
        let target = email.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        guard isValidEmail(target) else {
            show("올바른 이메일을 입력해주세요.")
            isEmailAvailable = nil
            return
        }

        isCheckingEmail = true   // 로딩 상태 시작
        defer { isCheckingEmail = false }

        do {
            // Firebase Auth에 이메일이 이미 존재하는지 확인
            let methods = try await Auth.auth().fetchSignInMethods(forEmail: target)
            print("🔎 signInMethods for \(target):", methods) // 디버그 로그

            if !methods.isEmpty {
                isEmailAvailable = false
                show("이미 등록된 이메일입니다.")
                return
            }

            // Firestore에도 같은 이메일이 존재하는지 확인
            let snap = try await Firestore.firestore()
                .collection("user")
                .whereField("email", isEqualTo: target)
                .limit(to: 1)
                .getDocuments()

            if !snap.documents.isEmpty {
                isEmailAvailable = false
                show("이미 등록된 이메일입니다.")
                return
            }

            // 통과 → 사용 가능
            isEmailAvailable = true
            show("사용 가능한 이메일입니다.")
        } catch {
            // 오류 발생 시
            isEmailAvailable = nil
            show("중복확인 중 오류: \(error.localizedDescription)")
        }
    }
}
