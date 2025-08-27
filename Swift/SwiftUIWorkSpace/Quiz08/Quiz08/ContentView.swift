//
//  ContentView.swift
//  Quiz06
//
//  Created by Jun Jong Eck on 8/5/25.
//

import SwiftUI

struct ContentView: View {
    let imageArray: [String] = ["flower_01","flower_02","flower_03", "flower_04", "flower_05", "flower_06"]
    @State var imageIndex: Int = 0
    @State var currentDate = Date()
    
    let timer = Timer.publish(every: 3, on: .main, in: .default).autoconnect()
    
    var body: some View {
        VStack {
            Text("3초마다 이미지 무한 반복")
                .bold()
                .font(.system(size: 15))
                .padding()
            
            Text("\(imageArray[imageIndex]).jpg")
                .bold()
                .font(.system(size: 15))
                .onReceive(timer, perform: {input in
                    self.imageIndex = (self.imageIndex + 1) % self.imageArray.count
                })
            
            ZStack {
                Image(imageArray[imageIndex])
                    .resizable()
                    .frame(width: 350, height: 500)
                    .clipShape(.rect(cornerRadius: 15))
                    .padding(.bottom, 50)
                    .scaledToFit()
                
                   
            }
            .clipped() // ZStack 부분 짤라내기
           

        }
        .padding()
    } // body
   
} // view

#Preview {
    ContentView()
}
