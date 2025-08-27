//
//  ContentView.swift
//  Switch
//
//  Created by Jun Jong Eck on 8/4/25.
//

import SwiftUI

struct ContentView: View {
    
    @State var num1 = ""
    @State var num2 = ""
    @State var num3 = ""
    @State var message = ""
    @FocusState var isTextFieldFocused: Bool // visible or invisible on softkeyboard
    
    
    var body: some View {
        
        Spacer()
        
        VStack(content: {
            Text("평균점수 등급 계산")
                .bold()
                .font(.system(size: 20))
                .padding()
            
            Spacer()

            
            HStack(content: {
                Text("국어")

                TextField("숫자입력", text: $num1)
                    .frame(width: 120)
                    .textFieldStyle(.roundedBorder)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.numberPad)
                    .focused($isTextFieldFocused) // 포커싱 상태 추적
            })
            
            HStack(content: {
                Text("과학")

                TextField("숫자입력", text: $num2)
                    .frame(width: 120)
                    .textFieldStyle(.roundedBorder)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.numberPad)
                    .focused($isTextFieldFocused) // 포커싱 상태 추적
            })
            
            HStack(content: {
                Text("수학")

                TextField("숫자입력", text: $num3)
                    .frame(width: 120)
                    .textFieldStyle(.roundedBorder)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.numberPad)
                    .focused($isTextFieldFocused) // 포커싱 상태 추적
            })

            Button("계산하기", action: {
                displayResult()
                isTextFieldFocused = false
            })
                .padding()
            
            
            Text(message)

            
            Spacer()
            

        })
        .padding()
    }
    
    // --- Functions

    
    // 계산하여 결과값을 화면에 보여주기
    func displayResult() {
        // 안전하게 Double로 변환
        guard let n1 = Double(num1),
              let n2 = Double(num2),
              let n3 = Double(num3) else {
            message = "유효한 숫자를 입력하세요."
            return
        }

        let avg = (n1 + n2 + n3) / 3
        let score = Int(avg)
        var grade = ""

        switch score {
        case 90...100:
            grade = "수"
        case 80..<90:
            grade = "우"
        case 70..<80:
            grade = "미"
        case 60..<70:
            grade = "양"
        default:
            grade = "가"
        }

        message = "평균은 \(String(format: "%.2f", avg)) 이고 등급은 \(grade)입니다."
    }
}


#Preview {
    ContentView()
}
