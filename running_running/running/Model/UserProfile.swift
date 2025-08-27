//
//  UserProfile.swift
//  running
//
//  Created by Jun Jong Eck on 8/20/25.
//
//  UserProfile.swift
import Foundation
import FirebaseAuth                       // Firebase User 타입 사용을 위해


struct UserProfile: Codable, Identifiable { // 사용자 프로필 모델. Codable(인코딩/디코딩), Identifiable(List 등에서 식별자 사용)
    var id: String { uid }                   // Identifiable 요구사항: 고유 id 제공. 여기서는 uid를 그대로 반환
    let uid: String                          // Firebase Auth 사용자 고유 ID
    var name: String                         // 사용자 이름
    var email: String                        // 사용자 이메일
    var identification: String               // 주민번호 앞 7자리(문자열) - Int로 받을경우 00년생, 01년생들 앞자리 0 인식 불가
    var isEmailVerified: Bool                // 이메일 인증 여부
    var createdAt: Date?                     // 생성 시각(옵션). 서버시간 권장 → VM에서 FieldValue.serverTimestamp 사용
    var hasCar: Bool                         // 차 보유 여부
    var hasChildren: Bool                    // 자녀 유무
    var heightCm: Double?                    // ex) 173.2
    var weightKg: Double?                    // ex) 68.5
    var imageAddress: String?                // 프로필 사진

    init(uid: String,                        // 직접 필드로 초기화하는 이니셜라이저
         name: String,
         email: String,
         identification: String,
         isEmailVerified: Bool,
         createdAt: Date? = nil,
         hasCar: Bool = false,
         hasChildren: Bool = false,
         heightCm: Double? = nil,
         weightKg: Double? = nil,
         imageAddress: String? = nil) {
        self.uid = uid                       // 전달받은 uid 설정
        self.name = name                     // 이름 설정
        self.email = email                   // 이메일 설정 (호출 측에서 lowercased 권장)
        self.identification = identification // 주민번호 앞 7자리 설정
        self.isEmailVerified = isEmailVerified // 이메일 인증 여부 설정
        self.createdAt = createdAt           // 생성 시각 설정(없으면 nil)
        self.hasCar = hasCar                 // 차 보유 여부 설정
        self.hasChildren = hasChildren       // 자녀 유무 설정
        self.heightCm = heightCm             // 키
        self.weightKg = weightKg             // 체중
        self.imageAddress = imageAddress     // 프로필 사진
    }

    init(user: User,                         // FirebaseAuth.User 로부터 생성하는 이니셜라이저
         name: String,
         identification: String,
         hasCar: Bool = false,
         hasChildren: Bool = false,
         heightCm: Double? = nil,
         weightKg: Double? = nil,
         imageAddress: String? = nil
    ) {
        self.uid = user.uid                  // Firebase 유저의 uid 사용
        self.name = name                     // 전달받은 이름 사용
        self.email = user.email?.lowercased() ?? "" // Firebase 유저 이메일(없으면 빈 문자열)
        self.identification = identification // 주민번호 앞 7자리
        self.isEmailVerified = user.isEmailVerified // Firebase 유저의 이메일 인증 여부
        self.createdAt = nil                 // 생성 시각은 여기서 설정하지 않음
        self.hasCar = hasCar                 // 차 보유 여부
        self.hasChildren = hasChildren       // 자녀 유무
        self.heightCm = heightCm             // 키
        self.weightKg = weightKg            // 체중
        self.imageAddress = imageAddress    // 프로필사진
    }

    // 서버시간 + 선택 필드 조건부 저장으로 수정
    func toDictionary() -> [String: Any] {
        var d: [String: Any] = [
            "uid": uid,
            "name": name,
            "email": email.lowercased(),
            "identification": identification,
            "isEmailVerified": isEmailVerified,
            "createdAt": Date(),
            "hasCar": hasCar,
            "hasChildren": hasChildren
        ]
        if let h = heightCm { d["heightCm"] = h }                 //  선택값만 저장
        if let w = weightKg { d["weightKg"] = w }                 //  선택값만 저장
        if let url = imageAddress, !url.isEmpty { d["imageAddress"] = url } // 선택값만 저장
        return d
    }
}
