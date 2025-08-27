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
    @State var frontIndex: Int = 1
    var body: some View {
        VStack {
            Text("\(imageArray[imageIndex]).jpg")
                .bold()
                .font(.system(size: 30))
            
            ZStack {
                Image(imageArray[imageIndex])
                    .resizable()
                    .frame(width: 350, height: 500)
                    .clipShape(.rect(cornerRadius: 15))
                    .padding(.bottom, 50)
                    .scaledToFit()
                
                Image(imageArray[frontIndex])
                    .resizable()
                    .frame(width: 100, height: 150)
                    .clipShape(.rect(cornerRadius: 15))
                    .fixedSize()
                    .scaledToFit()
                    .offset(x: 125, y: -195)
                    .overlay(content:{
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.red, lineWidth: 5)
                            .offset(x: 123, y: -197)
                    })
                   
            }
            .clipped() // ZStack 부분 짤라내기
            
            HStack(spacing:70, content: {
                Button("이전", action: {
                    previousImage()
                })
                Button("다음", action: {
                    nextImage()
                })
            })
        }
        .padding()
    } // body
    
    func previousImage() {
        imageIndex -= 1
        if imageIndex < 0 {
            imageIndex = imageArray.count - 1
        }
        frontIndex -= 1
        if frontIndex < 0 {
            frontIndex = imageArray.count - 1
        }
    }
    
    
    func nextImage() {
        imageIndex += 1
        if imageIndex >= imageArray.count {
            imageIndex = 0
        }
        frontIndex += 1
        if frontIndex >= imageArray.count {
            frontIndex = 0
        }
    }
    
    
    
} // view

#Preview {
    ContentView()
}
