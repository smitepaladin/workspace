//
//  ContentView.swift
//  Calc
//
//  Created by Jun Jong Eck on 8/5/25.
//

import SwiftUI

struct ContentView: View {
    @FocusState var isTextFieldFocused: Bool
    @State var firstNumber = ""
    @State var secondNumber = ""
    @State var result = ""
    
    var body: some View {
        VStack(content :{
            Text("구조체를 통한 덧셈 계산")
                .bold()
                .padding(.bottom, 80)
            
            HStack(content: {
                Text("첫번째 숫자")
                
                TextField("0", text: $firstNumber)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 100)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.numberPad)
                    .focused($isTextFieldFocused)
            })
            
            HStack(content: {
                Text("두번째 숫자")
                
                TextField("0", text: $secondNumber)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 100)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.numberPad)
                    .focused($isTextFieldFocused)
            })
            
            Button("Add", action:{
                let num1 = Int(firstNumber) ?? 0
                let num2 = Int(secondNumber) ?? 0
                
                let addition = Addition()
                result = String(addition.add(num1, num2))
                isTextFieldFocused = false
            })
            .frame(width: 120, height: 40)
            .background(.blue)
            .foregroundStyle(.white)
            .clipShape(.buttonBorder)
            .padding()
            
            ZStack(content: {
                Color.gray.ignoresSafeArea(edges: .all)
                Text(result)
                    .bold()
            })
            .frame(width : 300, height: 50)
        })
    } // Body
} // View

#Preview {
    ContentView()
}
