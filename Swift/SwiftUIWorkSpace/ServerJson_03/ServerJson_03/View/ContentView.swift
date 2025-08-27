//
//  ContentView.swift
//  ServerJson_03
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
                        
                        VStack(alignment: .leading,content: {
                            Image(systemName: "sun.max")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundStyle(.red)
                        })
                        Spacer()
                        VStack(alignment: .leading, content:{
                            Text("성명 : \(student.name)")
                                .font(.system(size: 18))
                                .bold()
                            Text("학번 : \(student.code)")

                        })
                        Spacer()
                       


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
