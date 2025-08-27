//
//  ContentView.swift
//  PickerView
//
//  Created by Jun Jong Eck on 8/5/25.
//

import SwiftUI

struct ContentView: View {
    let imageFileName = ["w1","w2","w3","w4","w5","w6","w7","w8","w9","w10"]
    @State var selectedImage = 0
    
    var body: some View {
        VStack(content: {
            Text("Pikcker로 이미지 선택")
                .bold()
            
            Picker("", selection: $selectedImage, content: {
                
                ForEach(0..<imageFileName.count, id: \.self, content: {index in
                 
//                    Text("\(imageFileName[index]).jpg") // Picker에 글씨 쓰기
                    
                    // Picker에 Image
                    Image(imageFileName[index])
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                })
            })
            .pickerStyle(.wheel)
            .padding()
            
            Text("Selected Item : \(imageFileName[selectedImage]).jpg")
                .padding()
            
            Image(imageFileName[selectedImage])
                .resizable()
                .frame(width: 350, height: 200)
                .scaledToFit()
                .clipShape(.rect(cornerRadius: 15))
        })
    }// Body
}// View

#Preview {
    ContentView()
}
