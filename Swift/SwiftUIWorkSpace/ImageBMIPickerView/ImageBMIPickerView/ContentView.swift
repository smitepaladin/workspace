//
//  ContentView.swift
//  ImageBMIPickerView
//
//  Created by Jun Jong Eck on 8/5/25.
//

import SwiftUI

struct ContentView: View {
    let height = [Int](100...200)
    let weight = [Int](30...200)
    
    @State var heightNumber = 0
    @State var weightNumber = 0
    @State var bmi = 0.0
    @State var grade = ""
    @State var imagename = ""
    @State var message = ""


    var body: some View {
        
        
        
        
        VStack {
            Text("BMI 측정기")
                .bold()
                .font(.system(size: 20))
                .padding()

            HStack {
                VStack(content: {
                    Text("신장(Cm)")
                        .bold()
                        .font(.system(size: 20))
                    
                    Picker("", selection: $heightNumber, content: {
                        // ForEach는 Closure를 사용
                        ForEach(0..<height.count, id: \.self, content: {index in
                            Text("\(height[index])")
                        })
                    })
                    .pickerStyle(.wheel)
                    .padding()
                    
                })
                
                
                VStack(content: {
                    Text("몸무게(Kg)")
                        .bold()
                        .font(.system(size: 20))
                    
                    Picker("", selection: $weightNumber, content: {
                        // ForEach는 Closure를 사용
                        ForEach(0..<weight.count, id: \.self, content: {index in
                            Text("\(weight[index])")
                        })
                    })
                    .pickerStyle(.wheel)
                    .padding()
                })
            }

            Button("계산하기", action: {
                displayResult()
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
        let h = Double(height[heightNumber])
        let w = Double(weight[weightNumber])

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

        message = "귀하의 BMI 지수는 \(String(format: "%.2f", bmi)) 이고 \(grade) 입니다."
    }
}

#Preview {
    ContentView()
}
