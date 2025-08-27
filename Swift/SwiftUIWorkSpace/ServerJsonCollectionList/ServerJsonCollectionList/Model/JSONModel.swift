//
//  JSONModel.swift
//  ServerJson_01
//
//  Created by Jun Jong Eck on 8/7/25.
//

import Foundation

struct MovieJSON: Decodable{
    let image: URL
    let title: String
}

extension MovieJSON: Hashable {// struct 에 기능추가
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
}
