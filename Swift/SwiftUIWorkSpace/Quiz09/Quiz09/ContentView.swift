//
//  ContentView.swift
//  MultiLine
//
//  Created by Jun Jong Eck on 8/4/25.
//

import SwiftUI

struct ContentView: View {
    
    let dan = [Int](2...9)
    @State var danNumber = 0
    @State var dispDan: String = ""
    
    var body: some View {
        
        VStack(content: {
            Text("\(dan[danNumber]) 단")
                .bold()
                .font(.system(size: 20))
            
            Picker("", selection: $danNumber, content: {
                // ForEach는 Closure를 사용
                ForEach(0..<dan.count, id: \.self, content: {index in
                    Text("\(dan[index]) 단")
                })
                .onChange(of: danNumber, {
                    calculation(dan[danNumber])
                })
            })
            .pickerStyle(.wheel)
            .padding()

            
            ScrollView(content: {
                Text(dispDan)
            })
            .lineLimit(20)
            .frame(width: 200, height: 250)
            .background(.gray.opacity(0.5))
            .clipShape(.rect(cornerRadius: 15))
            .onAppear(perform: {
                calculation(2)
            })
            
        })
        
    } // body
    
    // --- Function ---
    func calculation(_ danCalc: Int){
        var tempDan: String = "\n"
        for i in 1...9{
            tempDan += "\(danCalc) X \(i) = \(danCalc * i) \n"
        }
        dispDan = tempDan
    }
}

#Preview {
    ContentView()
}
