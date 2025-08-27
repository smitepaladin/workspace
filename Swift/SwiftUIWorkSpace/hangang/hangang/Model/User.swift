//
//  User.swift
//  hangang
//
//  Created by Jun Jong Eck on 8/19/25.
//

import Foundation

struct User: Codable, Equatable {
    let uid: String?
    let email: String?
    let name: String?

    // 키 이름이 살짝 달라도 받아줌 (e.g. displayName vs name)
    enum CodingKeys: String, CodingKey {
        case uid, email, name
        case displayName
    }
    init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        uid   = try? c.decode(String.self, forKey: .uid)
        email = try? c.decode(String.self, forKey: .email)
        name  = (try? c.decode(String.self, forKey: .name)) ?? (try? c.decode(String.self, forKey: .displayName))
    }
    init(uid: String? = nil, email: String? = nil, name: String? = nil) {
        self.uid = uid; self.email = email; self.name = name
    }
}

struct JoinResponse: Codable {
    // 흔한 패턴: { "result":"ok", "msg":"...", "user":{...} }
    let result: String?
    let msg: String?
    let user: User?
}

struct LoginResponse: Codable {
    // 흔한 패턴: { "result":"ok", "idToken":"...", "refreshToken":"...", "user":{...} }
    let result: String?
    let msg: String?
    let idToken: String?
    let refreshToken: String?
    let user: User?
}
