//
//  ContentView.swift
//  RealmSimpleTodoList
//
//  Created by Jun Jong Eck on 8/8/25.
//
import SwiftUI
import RealmSwift

struct ContentView: View {
    @StateObject var realmManager = RealmManager()
    
    @State var isSheet: Bool = false
    @State var userInput: String = ""
    
    var body: some View {
        NavigationView {
            List {
                ForEach(realmManager.todoLists, content: { todo in
                    BasicImageRow(todolist: todo)
                })
                .onDelete(perform: { indexSet in
                    deleteItem(at: indexSet)
                })
            }
            .navigationTitle("Main View")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Image(systemName: "plus.circle")
                        .onTapGesture {
                            isSheet.toggle()
                        }
                        .sheet(isPresented: $isSheet) {
                            VStack {
                                Text("추가할 내용을 입력하세요")
                                    .bold()
                                    .padding()
                                
                                TextField("추가할 내용 입력", text: $userInput)
                                    .padding()
                                    .textFieldStyle(.roundedBorder)
                                
                                Button("OK", action: {
                                    isSheet.toggle()
                                    if userInput != "" {
                                        
                                        realmManager.addTodoList(TodoList(value: ["items": userInput]))

                                        userInput = ""
                                    }
                                })
                            }
                        }
                }
            }
        }
    }
    
    // 삭제 함수
    func deleteItem(at offsets: IndexSet) {
        for index in offsets {
            let todolists = realmManager.todoLists[index]
            realmManager.deleteTodoList(todolists)
            
        }
    }
}

struct BasicImageRow: View {
    var todolist: TodoList
    
    var body: some View {
        HStack {
            Image(systemName: "house.circle")
                .font(.system(size: 50))
            
            Text(todolist.items)
        }
    }
}

// 프리뷰
#Preview {
    ContentView()
}
