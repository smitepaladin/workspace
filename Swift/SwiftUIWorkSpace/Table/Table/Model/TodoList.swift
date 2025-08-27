//
//  TodoList.swift
//  Table
//
//  Created by Jun Jong Eck on 8/6/25.
//

import Foundation

struct TodoList: Identifiable {
    var id = UUID() // Unique Identifier
    var items: String
    var itemsImageFile: String
}
