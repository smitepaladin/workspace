//
//  TodoList.swift
//  SimpleTodoList
//
//  Created by Jun Jong Eck on 8/6/25.
//

import RealmSwift
import UIKit

class TodoList: Object, Identifiable {
    @Persisted(primaryKey: true) var id: ObjectId // Int와 String을 같이 쓰기 위해 ObjectId를 썼다.
    @Persisted var items: String = ""
}
