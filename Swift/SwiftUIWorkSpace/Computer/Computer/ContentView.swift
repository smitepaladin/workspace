//
//  ContentView.swift
//  Computer
//
//  Created by Jun Jong Eck on 8/1/25.
//

import SwiftUI

struct ContentView: View {
    // Property
    @State var productName = ""
    @State var screenSize = ""
    @State var weight = ""
    @State var bag = ""
    @State var color = ""
    var body: some View {
        
        VStack(content: {
            Text("Computer 사양")
                .bold()
                .padding(50)
                
            HStack(spacing: 10, content: { // HStack 안에 공백
                Text("제품명 :")
                    .frame(minWidth: 80, alignment: .leading)
                TextField("제품명을 입력하세요.", text: $productName)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 200) // 입력도 받아야 하기 때문에 $가 들어간다.
            })
            HStack(spacing: 10, content: { // HStack 안에 공백
                Text("화면크기 :")
                    .frame(minWidth: 80, alignment: .leading)
                TextField("화면크기를 입력하세요", text: $screenSize)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 200) // 입력도 받아야 하기 때문에 $가 들어간다.
            })
            HStack(spacing: 10, content: { // HStack 안에 공백
                Text("무게 :")
                    .frame(minWidth: 80, alignment: .leading)
                TextField("무게를 입력하세요.", text: $weight)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 200) // 입력도 받아야 하기 때문에 $가 들어간다.
            })
            HStack(spacing: 10, content: { // HStack 안에 공백
                Text("가방 :")
                    .frame(minWidth: 80, alignment: .leading)
                TextField("가방 유무를 입력하세요.", text: $bag)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 200) // 입력도 받아야 하기 때문에 $가 들어간다.
            })
            HStack(spacing: 10, content: { // HStack 안에 공백
                Text("색상")
                    .frame(minWidth: 80, alignment: .leading)
                TextField("색상을 입력하세요.", text: $color)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 200) // 입력도 받아야 하기 때문에 $가 들어간다.
            })
            
            Spacer()
            // OK Button
            Button("OK", action: {
                let productName_T: String = "맥북프로"
                let screenSize_T: Int = 16
                let weight_T: Double = 2.56
                let bag_T: Bool = false
                let color_T: Character = "은"
                
                productName = productName_T
                screenSize = String(screenSize_T)
                weight = String(weight_T)
                bag = String(bag_T)
                color = String(color_T)
            })
            .padding()
            .frame(width: 80)
            .background(.blue)
            .foregroundStyle(.white)
            .clipShape(.buttonBorder)
            
            // Clear button
            Button("Clear", action: {
                productName.removeAll()
                screenSize.removeAll()
                weight.removeAll()
                bag.removeAll()
                color.removeAll()
            })
            .padding()
            .frame(width: 80)
            .foregroundStyle(.red)
            .border(.red, width: 1)
            
            Spacer()
        })
        .padding()
        
    } // body
} // ContentView

#Preview {
    ContentView()
}
