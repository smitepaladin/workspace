//
//  JSONModel.swift
//  ServerJson_03
//
//  Created by Jun Jong Eck on 8/7/25.
//

import Foundation

struct quoteJSON: Decodable{
    let quote: String
    let name: String
}

extension quoteJSON: Hashable {// struct 에 기능추가
    func hash(into hasher: inout Hasher) {
        hasher.combine(quote)
    }
}
