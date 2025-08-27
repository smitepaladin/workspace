//
//  DetailView.swift
//  Table
//
//  Created by Jun Jong Eck on 8/6/25.
//

import SwiftUI

struct DetailView: View {
    var todolist: TodoList
    
    var body: some View {
        VStack(content: {
            Image(todolist.itemsImageFile)
                .resizable()
                .frame(width: 100, height: 100)
                .fixedSize()
                .padding(.bottom, 10)
                .scaledToFit()
            
            Text(todolist.items)
        })
        .navigationTitle("Detail View")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    DetailView(todolist: TodoList(items: "aaa", itemsImageFile: "cart"))
}
