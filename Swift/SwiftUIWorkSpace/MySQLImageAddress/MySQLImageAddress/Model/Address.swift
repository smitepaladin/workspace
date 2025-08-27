//
//  Address.swift
//  MySQLImageAddress
//
//  Created by Jun Jong Eck on 8/11/25.
//

import Foundation

struct AddressJSON: Decodable {
    var id: Int
    var name: String
    var phone: String
    var address: String
    var relation: String
    var image: String
}

extension AddressJSON: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
