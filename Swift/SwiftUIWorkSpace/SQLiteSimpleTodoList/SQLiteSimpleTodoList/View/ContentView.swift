import SwiftUI

struct ContentView: View {
    @State var todoLists: [TodoList] = []
    @State var isSheet: Bool = false
    @State var userInput: String = ""
    
    private let db = TodoListDB()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(todoLists, id: \.id, content: { todo in
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
                        .onTapGesture { isSheet.toggle() }
                        .sheet(isPresented: $isSheet) {
                            VStack {
                                Text("추가할 내용을 입력하세요")
                                    .bold()
                                    .padding()
                                
                                TextField("추가할 내용 입력", text: $userInput)
                                    .padding()
                                    .textFieldStyle(.roundedBorder)
                                
                                Button("OK") {
                                    isSheet.toggle()
                                    if !userInput.isEmpty {
                                        if db.insertDB(item: userInput) {
                                            // DB 저장 성공 → 목록 다시 불러오기
                                            todoLists = db.queryDB()
                                        }
                                        userInput = ""
                                    }
                                }
                            }
                            .padding()
                        }
                }
            }
        }
        .onAppear (perform: {
            todoLists.removeAll()
            let todoListDB = TodoListDB()
            todoLists = todoListDB.queryDB() // 앱 실행 시 DB에서 목록 로드
        })
    }
    
    // 삭제 함수
    func deleteItem(at indexSet: IndexSet) {
        for index in indexSet {
            let todo = todoLists[index]
            if db.deleteDB(id: todo.id) {
                todoLists.remove(at: index)
            }
        }
    }
}

struct BasicImageRow: View {
    var todolist: TodoList
    
    var body: some View {
        HStack {
            Image(systemName: "house.circle")
                .font(.system(size: 50))
            
            Text(todolist.item) // 모델에서 'item'으로 정의됨
        }
    }
}

#Preview {
    ContentView()
}
