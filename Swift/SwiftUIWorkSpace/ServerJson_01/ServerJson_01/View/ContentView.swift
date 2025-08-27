//
//  ContentView.swift
//  ServerJson_01
//
//  Created by Jun Jong Eck on 8/7/25.
//

import SwiftUI

struct ContentView: View {
    
    @State var students: [StudentJSON] = []
    
    var body: some View {
        NavigationView(content: {
            List(students, id:\.code, rowContent: {student in // List는 Foreach필요없다
                VStack(alignment: .leading, content: {
                    HStack{
                        VStack(alignment: .leading, content:{
                            Text("성명 : \(student.name)")
                            Text("학번 : \(student.code)")
                                .font(.system(size: 18))
                                .bold()
                        })
                        Spacer()
                        
                        VStack(alignment: .leading, content:{
                            Text("전공 : \(student.dept)")
                            Text("전화번호 : \(student.phone)")
                        })

                    }
                    .padding()

                    })
            })
            .navigationTitle("Student")
        })
        .padding()
        .onAppear {
            let queryModel = QueryModel()
            Task {
                students = try await queryModel.loadData(url: URL(string: "https://zeushahn.github.io/Test/ios/student.json")!)
            }
        }
    } // body
}// View

#Preview {
    ContentView()
}
