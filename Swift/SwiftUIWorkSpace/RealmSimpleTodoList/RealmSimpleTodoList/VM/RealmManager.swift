//
//  RealmManager.swift
//  RealmSimpleTodoList
//
//  Created by Jun Jong Eck on 8/8/25.
//


import RealmSwift
import SwiftUI

class RealmManager : ObservableObject { // ObservableObject는 메모리에 존재
    private var realm: Realm?
    
    @Published var todoLists: [TodoList] = []
    
    init() {
        do{
            realm = try Realm()
            fetchTodoLists()
        }catch{
            print("Error Initializing Realm: \(error)")
        }
    }
    
    func fetchTodoLists() {
        guard let realm = realm else { return }
        let results = realm.objects(TodoList.self) // 모델 Contact 의 모든것을 다 가져와라
        todoLists = Array(results) // Arrary에 넣어준다.
        // Return이 없다. View에서 직접 가져와야한다.
        
        
    }
    
    func addTodoList(_ todoList: TodoList){
        guard let realm = realm else { return }
        do{
            try realm.write {
                realm.add(todoList)
            }
            fetchTodoLists()
        }catch{
            print("Error adding contact: \(error)")
        }
    }
    
    
    func deleteTodoList(_ todoList: TodoList){
        guard let realm = realm else { return }
        do{
            try realm.write {
                realm.delete(todoList)
            }
            fetchTodoLists()
        }catch{
            print("Error deleting contact: \(error)")
        }
    }

}
