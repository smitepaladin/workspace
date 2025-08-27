//
//  JSONModel.swift
//  ServerJson_03
//
//  Created by Jun Jong Eck on 8/7/25.
//

import Foundation

struct newsJSON: Decodable{
    let image: URL
    let category: String
    let heading: String
    let author: String
}

extension newsJSON: Hashable {// struct 에 기능추가
    func hash(into hasher: inout Hasher) {
        hasher.combine(image)
    }
}
