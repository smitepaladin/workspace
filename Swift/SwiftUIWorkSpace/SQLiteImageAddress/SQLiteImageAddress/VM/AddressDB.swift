//
//  AddressDB.swift
//  SQLiteImageAddress
//
//  Created by MACBOOK on 8/8/25.
//

import SQLite3
import SwiftUI

class AddressDB: ObservableObject{
    var db: OpaquePointer?
    var addressList: [Address] = []
    
    init() {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("address.sqlite")
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("error opening database")
        }
    
        
        // Table 만들기
        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS address (sid INTEGER PRIMARY KEY AUTOINCREMENT, sname TEXT, sphone TEXT, saddress TEXT, srelation TEXT, simage BLOB)", nil, nil, nil ) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
        }
    }
    
    func insertDB(name: String, phone: String, address: String, relation: String, image: UIImage) -> Bool {
        var stmt : OpaquePointer?
        let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
        
        let queryString = "INSERT INTO address (sname, sphone, saddress, srelation, simage) VALUES (?,?,?,?,?)"
        
        sqlite3_prepare(db, queryString, -1, &stmt, nil)
        
        sqlite3_bind_text(stmt, 1, name, -1, SQLITE_TRANSIENT)
        sqlite3_bind_text(stmt, 2, phone, -1, SQLITE_TRANSIENT)
        sqlite3_bind_text(stmt, 3, address, -1, SQLITE_TRANSIENT)
        sqlite3_bind_text(stmt, 4, relation, -1, SQLITE_TRANSIENT)
        
        let imageDate = image.jpegData(compressionQuality: 0.4)! as NSData
        sqlite3_bind_blob(stmt, 5, imageDate.bytes, Int32(imageDate.length), SQLITE_TRANSIENT)
        
        if sqlite3_step(stmt) == SQLITE_DONE {
            return true
        } else {
            return false
        }
    }
    
    func queryDB() -> [Address]{
        var stmt : OpaquePointer?
        
        let queryString = "SELECT * FROM address"
        
        sqlite3_prepare(db, queryString, -1, &stmt, nil)
        
        
        while(sqlite3_step(stmt) == SQLITE_ROW){
            let id = Int(sqlite3_column_int(stmt, 0))
            let name = String(cString: sqlite3_column_text(stmt, 1))
            let phone = String(cString: sqlite3_column_text(stmt, 2))
            let address = String(cString: sqlite3_column_text(stmt, 3))
            let relation = String(cString: sqlite3_column_text(stmt, 4))
            
            var image: UIImage = UIImage()
            
            if let dataBlob = sqlite3_column_blob(stmt, 5) {
                let dataBlobPath = sqlite3_column_bytes(stmt, 5)
                let data = Data(bytes: dataBlob, count: Int(dataBlobPath))
                image = UIImage(data: data)!
            }
         
            addressList.append(Address(id: id, name: name, phone: phone, address: address, relation: relation, image: image))
            
        }
        
        return addressList
        
    }
    
    func deleteDB(id: Int) -> Bool {
        var stmt : OpaquePointer?
        
        
        let queryString = "DELETE FROM address WHERE sid = ?"
        
        sqlite3_prepare(db, queryString, -1, &stmt, nil)
        
        sqlite3_bind_int(stmt, 1, Int32(id))
        
        if sqlite3_step(stmt) == SQLITE_DONE {
            return true
        } else {
            return false
        }
    }

    func updateDB(id: Int, name: String, phone: String, address: String, relation: String, image: UIImage) -> Bool {
        var stmt : OpaquePointer?
        let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
        
        let queryString = "UPDATE address SET sname = ?, sphone = ?, saddress = ?, srelation = ?, simage = ? WHERE sid = ?"
        
        sqlite3_prepare(db, queryString, -1, &stmt, nil)
        
        sqlite3_bind_text(stmt, 1, name, -1, SQLITE_TRANSIENT)
        sqlite3_bind_text(stmt, 2, phone, -1, SQLITE_TRANSIENT)
        sqlite3_bind_text(stmt, 3, address, -1, SQLITE_TRANSIENT)
        sqlite3_bind_text(stmt, 4, relation, -1, SQLITE_TRANSIENT)
        
        let imageDate = image.jpegData(compressionQuality: 0.4)! as NSData
        sqlite3_bind_blob(stmt, 5, imageDate.bytes, Int32(imageDate.length), SQLITE_TRANSIENT)
        
        sqlite3_bind_int(stmt, 6, Int32(id))
        
        if sqlite3_step(stmt) == SQLITE_DONE {
            return true
        } else {
            return false
        }
    }
    
    
}
