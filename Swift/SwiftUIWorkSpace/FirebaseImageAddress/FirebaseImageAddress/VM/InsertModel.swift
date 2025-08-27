//
//  InsertModel.swift
//  FirebaseImageAddress
//
//  Created by Jun Jong Eck on 8/11/25.
//

import Foundation
import Firebase

struct InsertModel{
    let db = Firestore.firestore()
    
    func insertItems(name: String, phone: String, address: String, relation: String, imageAddress: String) -> Bool{
        var status: Bool = true
        
        db.collection("addresslists").addDocument(data: [
            "name" : name,
            "phone" : phone,
            "address" : address,
            "relation" : relation,
            "imageAddress" : imageAddress
        ]){ error in
            if error != nil{
                status = false
            }else{
                status = true
            }
        }
        return status
    }
}
