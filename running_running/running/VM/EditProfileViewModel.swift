//
//  EditProfileViewModel.swift
//  running
//
//  Created by Jun Jong Eck on 8/20/25.
//

import Foundation
import FirebaseAuth      // Firebase 인증 관련
import FirebaseFirestore // Firestore 데이터베이스 사용
import FirebaseStorage // FirebaseStorage 사용

@MainActor
final class EditProfileViewModel: ObservableObject {
    // 입력값 ----------------------
    @Published var currentPassword: String = ""   // 현재 비밀번호
    @Published var newPassword: String = ""       // 새 비밀번호
    @Published var confirmNewPassword: String = ""// 새 비밀번호 확인용

    @Published var hasCar: Bool = false           // 차 보유 여부
    @Published var hasChildren: Bool = false      // 자녀 유무

    // UI 상태 ----------------------
    @Published var isLoading: Bool = false        // 로딩 상태 표시
    @Published var alertMessage: String?          // 알림창에 표시할 메시지
    @Published var didSaveFlags: Bool = false     // 기본 정보 저장 완료 여부
    @Published var didChangePassword: Bool = false// 비밀번호 변경 완료 여부
    
    // 선택 입력 & 사진 상태
    @Published var heightText: String = ""        // ""면 미입력 → 저장 시 필드 삭제
    @Published var weightText: String = ""        // ""면 미입력 → 저장 시 필드 삭제
    @Published var profileImageData: Data? = nil  // PhotosPicker에서 받은 Data
    @Published var currentPhotoURL: String? = nil // Firestore의 imageAddress

    // 초기 로드: Firestore에서 hasCar / hasChildren 불러오기
    func loadFlags() async {
        guard let uid = Auth.auth().currentUser?.uid else { // 현재 로그인한 사용자 UID 가져오기
            alert("로그인이 필요합니다.")
            return
        }
        isLoading = true
        defer { isLoading = false } // 함수 종료 시 자동으로 false

        do {
            // Firestore에서 현재 유저 문서 가져오기
            let snap = try await Firestore.firestore()
                .collection("user")
                .document(uid)
                .getDocument()

            // 데이터가 있으면 차/자녀 여부 불러오기
            if let data = snap.data() {
                self.hasCar = data["hasCar"] as? Bool ?? false
                self.hasChildren = data["hasChildren"] as? Bool ?? false
            }
        } catch {
            alert("프로필 정보를 불러오지 못했습니다: \(error.localizedDescription)")
        }
    }
    
    // 이미지 포맷 판별
    private func sniffImageFormat(_ data: Data) -> (ext: String, mime: String) {
        if data.starts(with: [0xFF, 0xD8, 0xFF]) { return ("jpg", "image/jpeg") }      // JPEG
        if data.starts(with: [0x89, 0x50, 0x4E, 0x47]) { return ("png", "image/png") } // PNG
        return ("dat", "application/octet-stream")
    }

    // 플래그 저장 (차 보유 여부, 자녀 유무)
    func saveFlags() async {
        guard let uid = Auth.auth().currentUser?.uid else { // UID 가져오기
            alert("로그인이 필요합니다.")
            return
        }
        isLoading = true
        defer { isLoading = false }

        do {
            // Firestore에 hasCar / hasChildren 값 저장 (merge: true → 기존 데이터 유지)
            try await Firestore.firestore()
                .collection("user")
                .document(uid)
                .setData([
                    "hasCar": hasCar,
                    "hasChildren": hasChildren
                ], merge: true)

            didSaveFlags = true
            alert("변경사항이 저장되었습니다.")
        } catch {
            alert("저장 중 오류가 발생했습니다: \(error.localizedDescription)")
        }
    }
    
    // 프로필로드
    func loadProfile() async {
        guard let uid = Auth.auth().currentUser?.uid else { alert("로그인이 필요합니다."); return }
        isLoading = true
        defer { isLoading = false }

        do {
            let snap = try await Firestore.firestore().collection("user").document(uid).getDocument()
            guard let d = snap.data() else { return }
            self.hasCar = d["hasCar"] as? Bool ?? false
            self.hasChildren = d["hasChildren"] as? Bool ?? false
            if let h = d["heightCm"] as? Double { self.heightText = "\(h)" } else { self.heightText = "" }
            if let w = d["weightKg"] as? Double { self.weightText = "\(w)" } else { self.weightText = "" }
            self.currentPhotoURL = d["imageAddress"] as? String
        } catch {
            alert("프로필 정보를 불러오지 못했습니다: \(error.localizedDescription)")
        }
    }
    
    // 프로필저장
    func saveProfile() async {
        guard let uid = Auth.auth().currentUser?.uid else { alert("로그인이 필요합니다."); return }
        isLoading = true
        defer { isLoading = false }

        do {
            var update: [String: Any] = [
                "hasCar": hasCar,
                "hasChildren": hasChildren
            ]

            // 키/몸무게: 빈 문자열이면 삭제, 숫자면 업데이트
            let hTrim = heightText.trimmingCharacters(in: .whitespacesAndNewlines)
            if hTrim.isEmpty {
                update["heightCm"] = FieldValue.delete()
            } else if let hv = Double(hTrim.replacingOccurrences(of: ",", with: ".")) {
                update["heightCm"] = hv
            }

            let wTrim = weightText.trimmingCharacters(in: .whitespacesAndNewlines)
            if wTrim.isEmpty {
                update["weightKg"] = FieldValue.delete()
            } else if let wv = Double(wTrim.replacingOccurrences(of: ",", with: ".")) {
                update["weightKg"] = wv
            }

            // (선택) 새 사진 업로드 → URL 저장
            if let data = profileImageData {
                let (ext, mime) = sniffImageFormat(data)
                let ref = Storage.storage().reference().child("profile_photos/\(uid).\(ext)")
                let meta = StorageMetadata(); meta.contentType = mime
                _ = try await ref.putDataAsync(data, metadata: meta)
                let url = try await ref.downloadURL().absoluteString
                update["imageAddress"] = url
                self.currentPhotoURL = url
                self.profileImageData = nil // 업로드 후 메모리 정리(선택)
            }

            try await Firestore.firestore().collection("user").document(uid).setData(update, merge: true)
            didSaveFlags = true
            alert("변경사항이 저장되었습니다.")
        } catch {
            alert("저장 중 오류가 발생했습니다: \(error.localizedDescription)")
        }
    }
    
    // 프로필 사진제거
    func removePhoto() async {
        guard let uid = Auth.auth().currentUser?.uid else { alert("로그인이 필요합니다."); return }
        isLoading = true
        defer { isLoading = false }

        do {
            try await Firestore.firestore().collection("user").document(uid)
                .setData(["imageAddress": FieldValue.delete()], merge: true)

            // 확장자를 모르면 둘 다 시도
            async let delJPG = Storage.storage().reference().child("profile_photos/\(uid).jpg").delete()
            async let delPNG = Storage.storage().reference().child("profile_photos/\(uid).png").delete()
            _ = try? await (delJPG, delPNG)

            self.currentPhotoURL = nil
            self.profileImageData = nil
            alert("프로필 사진이 제거되었습니다.")
        } catch {
            alert("사진 제거 중 오류가 발생했습니다: \(error.localizedDescription)")
        }
    }

    // 비밀번호 변경
    func changePassword() async {
        guard let user = Auth.auth().currentUser else { // 현재 로그인된 유저 확인
            alert("로그인이 필요합니다.")
            return
        }
        guard let email = user.email else { // 이메일 확인
            alert("이 계정의 이메일을 확인할 수 없습니다.")
            return
        }

        // 기본 검증 -----------------
        guard !currentPassword.isEmpty else { return alert("현재 비밀번호를 입력해주세요.") }
        guard isPasswordValid(newPassword) else { // 새 비밀번호 유효성 체크
            return alert("새 비밀번호 형식을 확인해주세요.\n(소문자, 숫자, 특수문자 포함 6자 이상)")
        }
        guard newPassword == confirmNewPassword else { // 새 비밀번호와 확인값 비교
            return alert("새 비밀번호와 확인이 일치하지 않습니다.")
        }

        isLoading = true
        defer { isLoading = false }

        do {
            // Firebase는 보안상 비밀번호 변경 시 최근 로그인 기록 필요 → 재인증 필수
            let credential = EmailAuthProvider.credential(withEmail: email, password: currentPassword)
            try await user.reauthenticate(with: credential)

            // 비밀번호 업데이트
            try await user.updatePassword(to: newPassword)
            didChangePassword = true

            // 입력칸 초기화
            currentPassword = ""
            newPassword = ""
            confirmNewPassword = ""
            alert("비밀번호가 변경되었습니다.")
        } catch let nsError as NSError {
            // Firebase 에러 코드별 처리
            if let code = AuthErrorCode(rawValue: nsError.code), code == .wrongPassword {
                alert("현재 비밀번호가 올바르지 않습니다.")
            } else if let code = AuthErrorCode(rawValue: nsError.code), code == .requiresRecentLogin {
                alert("보안을 위해 다시 로그인 후 시도해주세요.")
            } else {
                alert("비밀번호 변경 실패: \(nsError.localizedDescription)")
            }
        } catch {
            alert("비밀번호 변경 실패: \(error.localizedDescription)")
        }
    }

    // 비밀번호 유효성 체크 (소문자, 숫자, 특수문자 포함 & 6자 이상)
    func isPasswordValid(_ password: String) -> Bool {
        let regex = "^(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$%^&*()_+=-]).{6,}$"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: password)
    }

    // 알림 메시지 설정
    private func alert(_ msg: String) { alertMessage = msg }
}
