//
//  ContentView.swift
//  Table
//
//  Created by Jun Jong Eck on 8/6/25.
//

import SwiftUI

struct ContentView: View {
    @State var todoLists: [TodoList] = [
        TodoList(items: "책 구매", itemsImageFile: "cart"),
        TodoList(items: "철수와 약속", itemsImageFile: "clock"),
        TodoList(items: "스터디 준비하기", itemsImageFile: "pencil")
    ]
    
    var body: some View {
        NavigationView(content: {
            List(content: {
                ForEach(todoLists, content: {todo in
                    NavigationLink(destination: DetailView(todolist: todo), label: {
                        BasicImageRow(todolist: todo)
                    })        
                })
            })
            .navigationTitle("Main View")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing, content: {
                    NavigationLink(destination: AddView(todoList: $todoLists), label: {
                        Image(systemName: "plus.circle")
                    })
                })
            })
        })

    }// Body
}//View


struct BasicImageRow: View {
    var todolist: TodoList
    
    var body: some View {
        HStack {
            Image(todolist.itemsImageFile)
                .resizable()
                .frame(width: 40, height: 40)
                .clipShape(.buttonBorder)

            Text(todolist.items)

        }
    }
}

#Preview {
    ContentView()
}
