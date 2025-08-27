//
//  JSONModel.swift
//  ServerJson_03
//
//  Created by Jun Jong Eck on 8/7/25.
//

import Foundation

struct StudentJSON: Decodable{
    let code: String
    let phone: String
    let name: String
    let dept: String
}

extension StudentJSON: Hashable {// struct 에 기능추가
    func hash(into hasher: inout Hasher) {
        hasher.combine(code)
    }
}
