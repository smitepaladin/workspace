import SwiftUI

struct ContentView: View {
    
    @State var num1 = ""
    @State var num2 = ""
    @State var addition = ""
    @State var message = "환영 합니다."
    @FocusState var isTextFieldFocused: Bool // visible or invisible on softkeyboard
    
    
    var body: some View {
        VStack(content: {
            Text("짝수인 경우에만 덧셈 실행")
                .bold()
                .font(.system(size: 20))
                .padding()
            
            Spacer()
            
            HStack(content: {
                Text("1번 숫자")

                TextField("숫자입력", text: $num1)
                    .frame(width: 120)
                    .textFieldStyle(.roundedBorder)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.numberPad)
                    .focused($isTextFieldFocused) // 포커싱 상태 추적
            })
            
            HStack(content: {
                Text("2번 숫자")

                TextField("숫자입력", text: $num2)
                    .frame(width: 120)
                    .textFieldStyle(.roundedBorder)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.numberPad)
                    .focused($isTextFieldFocused) // 포커싱 상태 추적
            })

            Button("판별하기", action: {
                let checkResult = inputCheck()
                if checkResult {
                    if checkevennumber() {
                        displayResult()
                        message = "입력하신 숫자의 합은 \(addition) 입니다."
                    } else {
                        message = "짝수만 입력하세요"
                    }
                } else {
                    message = "숫자를 입력 하세요"
                }

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
    func checkevennumber() -> Bool {
        if let n1 = Int(num1), let n2 = Int(num2) {
            return n1 % 2 == 0 && n2 % 2 == 0
        }
        return false
        
    }
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
    }
}


#Preview {
    ContentView()
}
