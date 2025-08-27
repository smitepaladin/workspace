//
//  ContentView.swift
//  imageBMI
//
//  Created by Jun Jong Eck on 8/4/25.
//

import SwiftUI

struct ContentView: View {
    
    @State var height = ""
    @State var weight = ""
    @State var bmi = 0.0
    @State var grade = ""
    @State var imagename = ""
    @State var message = ""
    @FocusState var isTextFieldFocused: Bool

    var body: some View {
        VStack {
            Text("BMI 측정기")
                .bold()
                .font(.system(size: 20))
                .padding()

            HStack {
                Text("신장(Cm):")
                TextField("0", text: $height)
                    .frame(width: 120)
                    .textFieldStyle(.roundedBorder)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.numberPad)
                    .focused($isTextFieldFocused)
            }

            HStack {
                Text("몸무게(Kg):")
                TextField("0", text: $weight)
                    .frame(width: 120)
                    .textFieldStyle(.roundedBorder)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.numberPad)
                    .focused($isTextFieldFocused)
            }
            .padding()

            Button("계산하기", action: {
                displayResult()
                isTextFieldFocused = false
            })
            .padding()
            .bold()
            .frame(width: 100)
            .background(.blue)
            .foregroundStyle(.white)
            .clipShape(.buttonBorder)

            Text(message)
                .padding()


                Image(imagename)
                    .resizable()
                    .frame(width: 300, height: 200)
                    .padding(.bottom, 100)

        }
        .padding()
    }

    func displayResult() {
        guard let h = Double(height), let w = Double(weight), h > 0, w > 0 else {
            message = "올바른 숫자를 입력하세요."
            return
        }

        bmi = w / pow(h / 100, 2)

        switch bmi {
        case ..<18.5:
            grade = "저체중"
            imagename = "underweight"
        case 18.5..<23:
            grade = "정상체중"
            imagename = "normal"
        case 23..<25:
            grade = "과체중"
            imagename = "risk"
        case 25..<30:
            grade = "비만"
            imagename = "overweight"
        default:
            grade = "고도비만"
            imagename = "obese"
        }
     message = "귀하의 BMI 지수는 \(String(format: "%.1f", bmi)) 이고 \(grade) 입니다."
    }
}

#Preview {
    ContentView()
}
