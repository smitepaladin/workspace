//
//  DBModel.swift
//  FirebaseImageAddress
//
//  Created by Jun Jong Eck on 8/11/25.
//

import Foundation

struct DBModel{
    var documentID: String
    var name: String
    var phone: String
    var address: String
    var relation: String
    var imageAddress: String
    
    init(documentID: String, name: String, phone: String, address: String, relation: String, imageAddress: String) {
        self.documentID = documentID
        self.name = name
        self.phone = phone
        self.address = address
        self.relation = relation
        self.imageAddress = imageAddress
    }
}
