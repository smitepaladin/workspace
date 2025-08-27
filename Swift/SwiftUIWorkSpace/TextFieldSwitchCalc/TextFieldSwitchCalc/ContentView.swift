//
//  ContentView.swift
//  TextFieldSwitchCalc
//
//  Created by Jun Jong Eck on 8/5/25.
//

import SwiftUI

struct ContentView: View {
    
    @State var num1 = ""
    @State var num2 = ""
    @State var addition = ""
    @State var subraction = ""
    @State var multiplication = ""
    @State var division = ""
    @State var message = "숫자 연산 입니다."
    @State var additionStatus:Bool = false
    @State var subractionStatus:Bool = false
    @State var multiplicationStatus:Bool = false
    @State var divisionStatus:Bool = false
    @FocusState var isTextFieldFocused: Bool // visible or invisible on softkeyboard
    
    
    var body: some View {
        VStack(content: {
            Text("간단한 계산기")
                .bold()
                .font(.system(size: 20))
                .padding()
            
            Spacer()
            
            HStack(content: {
                Text("첫번째 숫자")

                TextField("0", text: $num1)
                    .frame(width: 120)
                    .textFieldStyle(.roundedBorder)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.numberPad)
                    .focused($isTextFieldFocused) // 포커싱 상태 추적
            })
            
            HStack(content: {
                Text("두번째 숫자")

                TextField("0", text: $num2)
                    .frame(width: 120)
                    .textFieldStyle(.roundedBorder)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.numberPad)
                    .focused($isTextFieldFocused) // 포커싱 상태 추적
            })

            HStack(content: {
                Button("계산하기", action: {
                    let checkResult = inputCheck()
                    if checkResult{
                        displayResult()
                        message = "계산이 완료 되었습니다."
                    }else{
                        message = "숫자를 입력 하세요!"
                    }
                    
                    isTextFieldFocused = false
                })
                .padding()
                .bold()
                .frame(width: 100)
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(.buttonBorder)
                
                Button("지우기", action: {
                    num1.removeAll()
                    num2.removeAll()
                    addition.removeAll()
                    subraction.removeAll()
                    multiplication.removeAll()
                    division.removeAll()
                    message = "숫자 연산 입니다."
                    additionStatus = false
                    subractionStatus = false
                    multiplicationStatus = false
                    divisionStatus = false
                    isTextFieldFocused = false
                })
                .padding()
                .bold()
                .frame(width: 100)
                .background(.red)
                .foregroundStyle(.white)
                .clipShape(.buttonBorder)
            })
            
            
            HStack(content: {
                
                Text("덧   셈")
                Toggle("", isOn: $additionStatus)
                    .labelsHidden() // 이걸 해야 화면에서 제대로 나온다.
                    .onChange(of: additionStatus) {oldValue, newValue in
                        if newValue {
                            if inputCheck() {
                                addition = String(Int(num1)! + Int(num2)!)
                                message = "계산이 완료 되었습니다."
                                isTextFieldFocused = false
                            } else{
                                message = "숫자를 입력 하세요!"
                            }
                        } else {
                            // 토글이 꺼지면 결과 초기화
                            message = "숫자 연산 입니다."
                            addition = ""
                        }
                    }
                
                Text("뺄   셈")
                Toggle("", isOn: $subractionStatus)
                    .labelsHidden() // 이걸 해야 화면에서 제대로 나온다.
                    .onChange(of: subractionStatus) {oldValue, newValue in
                        if newValue {
                            // 토글이 켜졌을 때만 계산
                            if inputCheck() {
                                subraction = String(Int(num1)! - Int(num2)!)
                                message = "계산이 완료 되었습니다."
                                isTextFieldFocused = false
                            }else{
                                message = "숫자를 입력 하세요!"
                            }
                        } else {
                            // 토글이 꺼지면 결과 초기화
                            message = "숫자 연산 입니다."
                            subraction = ""
                        }
                    }
                
            })
            
            HStack(content: {
                
                Text("곱   셈")
                Toggle("", isOn: $multiplicationStatus)
                    .labelsHidden() // 이걸 해야 화면에서 제대로 나온다.
                    .onChange(of: multiplicationStatus) {oldValue, newValue in
                        if newValue {
                            // 토글이 켜졌을 때만 계산
                            if inputCheck() {
                                multiplication = String(Int(num1)! * Int(num2)!)
                                message = "계산이 완료 되었습니다."
                                isTextFieldFocused = false
                            }else{
                                message = "숫자를 입력 하세요!"
                            }
                        } else {
                            // 토글이 꺼지면 결과 초기화
                            message = "숫자 연산 입니다."
                            multiplication = ""
                        }
                    }
                
                Text("나눗셈")
                Toggle("", isOn: $divisionStatus)
                    .labelsHidden() // 이걸 해야 화면에서 제대로 나온다.
                    .onChange(of: divisionStatus) {oldValue, newValue in
                        if newValue {
                            // 토글이 켜졌을 때만 계산
                            if inputCheck() {
                                division = String(format: "%.2f", Double(num1)! / Double(num2)!)
                                message = "계산이 완료 되었습니다."
                                isTextFieldFocused = false
                            }else{
                                message = "숫자를 입력 하세요!"
                            }
                        } else {
                            // 토글이 꺼지면 결과 초기화
                            message = "숫자 연산 입니다."
                            division = ""
                        }
                    }
            })
            
            HStack(content: {
                Text("덧셈 결과 :")
                    .frame(minWidth: 100, alignment: .leading)
                
                TextField("", text: $addition)
                    .frame(width: 120)
                    .textFieldStyle(.roundedBorder)
                    .multilineTextAlignment(.trailing)
                    .disabled(true) // read only
            })
            
            HStack(content: {
                Text("뺄셈 결과 :")
                    .frame(minWidth: 100, alignment: .leading)
                
                TextField("", text: $subraction)
                    .frame(width: 120)
                    .textFieldStyle(.roundedBorder)
                    .multilineTextAlignment(.trailing)
                    .disabled(true) // read only
            })

            HStack(content: {
                Text("곱셈 결과 :")
                    .frame(minWidth: 100, alignment: .leading)
                
                TextField("", text: $multiplication)
                    .frame(width: 120)
                    .textFieldStyle(.roundedBorder)
                    .multilineTextAlignment(.trailing)
                    .disabled(true) // read only
            })

            HStack(content: {
                Text("나눗셈 결과 :")
                    .frame(minWidth: 100, alignment: .leading)
                
                TextField("", text: $division)
                    .frame(width: 120)
                    .textFieldStyle(.roundedBorder)
                    .multilineTextAlignment(.trailing)
                    .disabled(true) // read only
            })
            
            Text(message)
                .padding()
            
            Spacer()

        })
        .padding()
    }
    
    // --- Functions
    
    // num1과 num2의 숫자 입력 유무 check
    func inputCheck() -> Bool{
        if(num1.isEmpty || num2.isEmpty){
            return false
        }
        return true
    }
    
    // 계산하여 결과값을 화면에 보여주기
    func displayResult(){
        addition = String(Int(num1)! + Int(num2)!)
        subraction = String(Int(num1)! - Int(num2)!)
        multiplication = String(Int(num1)! * Int(num2)!)
        division = String(format: "%.2f", Double(num1)! / Double(num2)!)
        additionStatus = true
        subractionStatus = true
        multiplicationStatus = true
        divisionStatus = true
    }
}


#Preview {
    ContentView()
}
