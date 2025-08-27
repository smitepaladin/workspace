//
//  DeleteModel.swift
//  FirebaseImageAddress
//
//  Created by Jun Jong Eck on 8/11/25.
//

import Foundation
import Firebase

struct DeleteModel{
    let db = Firestore.firestore()
    
    func deleteItems(documentID: String) async throws -> Bool{
        do{
            try await db.collection("addresslists").document(documentID).delete()
            return true
        }catch{
            print("Error deleting document: \(error)")
            return false
        }
        
    }
}
