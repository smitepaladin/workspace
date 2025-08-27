//
//  ContentView.swift
//  HelloWorld
//
//  Created by Jun Jong Eck on 8/1/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
            Spacer()
            Text("Hello, World!")
                .font(.system(size: 20))
                .bold()
                .foregroundColor(.blue)
                .padding()
                .background(.yellow)

            Spacer()
            
            Text("Hello, World!")
                .font(.system(size: 20))
                .bold()
                .foregroundColor(.blue)
                .padding()
                .background(.yellow)
            
            Spacer()
        }
    } // body
} // ContentView


// struct는 class다 메모리크기는 struct가 작다.
// class는 상속이 되지만 struct는 상속이 안 된다.
// View에서 상속받은 struct ContentView
// View전체가 body이며 appbar는 없다.
// Vstack이 column. Hstack은 아래로 쌓으며 row. 위로 쌓으면 Zstack
// Image 가 이미지. 지구본모양
// 밑에 글자가 Text
#Preview {
    ContentView()
}

//Preview가 오른쪽에 폰 보여주는 것
