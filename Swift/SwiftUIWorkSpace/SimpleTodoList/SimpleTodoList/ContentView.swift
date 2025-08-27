import SwiftUI

struct ContentView: View {
    @State var todoLists: [TodoList] = [
        TodoList(items: "꽃 선물 준비")
    ]
    @State var isSheet: Bool = false
    @State var userInput: String = ""
    
    var body: some View {
        NavigationView {
            List {
                ForEach(todoLists, content: { todo in
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
                                        todoLists.append(TodoList(items: userInput))
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
    func deleteItem(at indexSet: IndexSet) {
        todoLists.remove(atOffsets: indexSet)
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
