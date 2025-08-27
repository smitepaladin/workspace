//
//  AddressDB.swift
//  SQLiteImageAddress
//
//  Created by MACBOOK on 8/8/25.
//

import SQLite3
import SwiftUI

class TodoListDB: ObservableObject{
    var db: OpaquePointer?
    var todoList: [TodoList] = []
    
    init() {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("todolist.sqlite")
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("error opening database")
        }
    
        
        // Table 만들기
        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS todolist (sid INTEGER PRIMARY KEY AUTOINCREMENT, sitem TEXT)", nil, nil, nil ) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
        }
    }
    
    func insertDB(item: String) -> Bool {
        var stmt : OpaquePointer?
        let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
        
        let queryString = "INSERT INTO todolist (sitem) VALUES (?)"
        
        sqlite3_prepare(db, queryString, -1, &stmt, nil)
        
        sqlite3_bind_text(stmt, 1, item, -1, SQLITE_TRANSIENT)
        if sqlite3_step(stmt) == SQLITE_DONE {
            return true
        } else {
            return false
        }
    }
    
    func queryDB() -> [TodoList]{
        var stmt : OpaquePointer?
        
        let queryString = "SELECT * FROM todolist"
        
        sqlite3_prepare(db, queryString, -1, &stmt, nil)
        
        
        while(sqlite3_step(stmt) == SQLITE_ROW){
            let id = Int(sqlite3_column_int(stmt, 0))
            let item = String(cString: sqlite3_column_text(stmt, 1))

         
            todoList.append(TodoList(id: id, item: item))
            
        }
        
        return todoList
        
    }
    
    func deleteDB(id: Int) -> Bool {
        var stmt : OpaquePointer?
        
        
        let queryString = "DELETE FROM todolist WHERE sid = ?"
        
        sqlite3_prepare(db, queryString, -1, &stmt, nil)
        
        sqlite3_bind_int(stmt, 1, Int32(id))
        
        if sqlite3_step(stmt) == SQLITE_DONE {
            return true
        } else {
            return false
        }
    }

    
    
}
