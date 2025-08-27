import SwiftUI

struct ContentView: View {
    @State var productName = ""
    @State var displayName = ""
    
    @FocusState private var isTextFieldFocused: Bool  // 포커스 상태 관리

    var body: some View {
        VStack {
            Spacer()

            // Welcome 메시지
            HStack(spacing: 10) {
                Text("Welcome! \(displayName)")
            }

            Spacer()

            // 입력창
            HStack(spacing: 10) {
                Text("Name :")
                    .frame(minWidth: 80, alignment: .leading)
                TextField("이름을 입력하세요.", text: $productName)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 200)
                    .focused($isTextFieldFocused)  // 포커스 연결
            }

            // 버튼들
            HStack(spacing: 10) {
                Button("Send", action: {
                    displayName = productName
                    isTextFieldFocused = false  // 키보드 내림
                })

                Button("Clear", action: {
                    productName.removeAll()
                    displayName.removeAll()
                    isTextFieldFocused = false  // 🔽 키보드 내림
                })
            }
            .padding()

            Spacer()
        }
    }
}

#Preview {
    ContentView()
}
