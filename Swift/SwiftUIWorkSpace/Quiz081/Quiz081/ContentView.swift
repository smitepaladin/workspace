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
    @State var imageIndex2: Int = 0
    @State var cnt = 0
    
      let timer = Timer.publish(every: 1, on: .main, in: .default).autoconnect()
    
    var body: some View {
        VStack {
            Text("1초와 3초마다 이미지 무한 반복")
                .bold()
                .font(.system(size: 15))
                .padding()
            
            // 위쪽 (1초마다)
            Text("\(imageArray[imageIndex]).jpg")
                .bold()
                .font(.system(size: 15))
            
            Image(imageArray[imageIndex])
                .resizable()
                .frame(width: 200, height: 300)
                .clipShape(.rect(cornerRadius: 15))
                .padding(.bottom, 50)
                .scaledToFit()
                .clipped()
            
            // 아래쪽 (3초마다)
            Text("\(imageArray[imageIndex2]).jpg")
                .bold()
                .font(.system(size: 15))
            
            Image(imageArray[imageIndex2])
                .resizable()
                .frame(width: 200, height: 300)
                .clipShape(.rect(cornerRadius: 15))
                .padding(.bottom, 50)
                .scaledToFit()
                .clipped()
        }
        .padding()
        .onReceive(timer) { _ in

            imageIndex = (imageIndex + 1) % imageArray.count

            cnt += 1
            if cnt % 3 == 0 {
                imageIndex2 = (imageIndex2 + 1) % imageArray.count
            }
        }
    }
}

#Preview {
    ContentView()
}
