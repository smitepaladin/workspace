//
//  ContentView.swift
//  Quiz32
//
//  Created by Jun Jong Eck on 8/4/25.
//
import SwiftUI

struct ContentView: View {
    
    @State var num1 = ""
    @State var num2 = ""
    @State var sum = 0
    @State var message = "환영 합니다."
    @FocusState var isTextFieldFocused: Bool // visible or invisible on softkeyboard
    
    
    var body: some View {

        VStack(content: {
            Text("범위의 합계 구하기")
                .bold()
                .font(.system(size: 20))
                .padding()
            
            Spacer()
            
            HStack(content: {
                Text("시작숫자 :")

                TextField("0", text: $num1)
                    .frame(width: 120)
                    .textFieldStyle(.roundedBorder)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.numberPad)
                    .focused($isTextFieldFocused) // 포커싱 상태 추적
            })
            
            HStack(content: {
                Text("끝   숫자 :")

                TextField("0", text: $num2)
                    .frame(width: 120)
                    .textFieldStyle(.roundedBorder)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.numberPad)
                    .focused($isTextFieldFocused) // 포커싱 상태 추적
            })

            Button("범위합계", action: {
                displayResult()
                message = "입력하신 숫자의 합은 \(sum) 입니다."
                isTextFieldFocused = false
            })
            
            Text(message)
                .padding()
            
            Spacer()

        })
        .padding()
    }
    
    // --- Functions
    // 짝수 판별하기
    
    
    // 계산하여 결과값을 화면에 보여주기
    func displayResult() {
        // 비어 있으면 "0"으로 대체
        let num1Value = num1.isEmpty ? "0" : num1
        let num2Value = num2.isEmpty ? "0" : num2

        guard let s = Int(num1Value),
              let e = Int(num2Value) else {
            message = "유효한 숫자를 입력하세요."
            return
        }

        let lower = min(s, e)
        let upper = max(s, e)

        sum = 0
        for i in lower...upper {
            sum += i
        }
    }
}


#Preview {
    ContentView()
}
