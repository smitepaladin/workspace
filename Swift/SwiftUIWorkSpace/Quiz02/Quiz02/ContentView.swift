import SwiftUI

struct ContentView: View {
    
    @State var num1 = ""
    @State var num2 = ""
    @State var addition = ""
    @State var subraction = ""
    @State var multiplication = ""
    @State var division = ""
    @State var message = "숫자 연산 입니다."
    @FocusState var isTextFieldFocused: Bool // visible or invisible on softkeyboard
    
    
    var body: some View {
        VStack(content: {
            Text("두개의 숫자 연산")
                .bold()
                .font(.system(size: 20))
                .padding()
            
            Spacer()
            
            HStack(content: {
                Text("첫번째 숫자")

                TextField("1st Number", text: $num1)
                    .frame(width: 120)
                    .textFieldStyle(.roundedBorder)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.numberPad)
                    .focused($isTextFieldFocused) // 포커싱 상태 추적
            })
            
            HStack(content: {
                Text("두번째 숫자")

                TextField("2nd Number", text: $num2)
                    .frame(width: 120)
                    .textFieldStyle(.roundedBorder)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.numberPad)
                    .focused($isTextFieldFocused) // 포커싱 상태 추적
            })

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
            .padding(.top, 10)
            
            Button("초기화", action: {
                num1.removeAll()
                num2.removeAll()
                addition.removeAll()
                subraction.removeAll()
                multiplication.removeAll()
                division.removeAll()
                message = "숫자 연산 입니다."
                
                isTextFieldFocused = false
            })
            .padding()
            
            Spacer()
            
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
    }
}


#Preview {
    ContentView()
}
