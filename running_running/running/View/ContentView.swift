//  ContentView.swift
//  running
//
//  Created by HeartFluttery on 8/19/25.
//

import SwiftUI
import FirebaseAuth // FirebaseAuth 인증 사용

struct LoginView: View {
    // 이메일 입력창 상태
    @State var email: String = ""
    // 비밀번호 입력창 상태
    @State var password: String = ""
    // 로그인 실패 횟수
    @State var errorCount: Int = 0
    // 3회 이상 실패 시 로그인 잠금 여부
    @State var isLocked: Bool = false
    // 알림창 표시 여부
    @State var showAlert: Bool = false
    // 알림창 메시지
    @State var alertMessage: String = ""
    
    // 로그인 성공 시 true → NavigationLink로 다음 화면 이동
    @State var isLoggedIn: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    
                    // 로그인 그림
                    HStack {
                        Image("login logo")
                            .resizable()
                            .frame(height: 200)
                    }
                    
                    // 앱 타이틀
                    HStack {
                        Spacer()
                        Text("Han River Runner")
                            .bold()
                            .font(.system(size: 30))
                        Spacer()
                    }
                    
                    // 이메일 입력창
                    TextField("Email", text: $email)
                        .keyboardType(.default) // 일반 키보드
                        .disabled(isLocked)     // 잠금 상태면 입력 불가
                        .autocapitalization(.none) // 자동 대문자 방지
                        .padding()
                        .background(Color(hex: 0xE5E8F5))
                        .cornerRadius(16)
                        .font(.system(size: 24))
                        .padding()
                    
                    // 비밀번호 입력창 (SecureField → 입력 시 마스킹)
                    SecureField("Password", text: $password)
                        .keyboardType(.default)
                        .disabled(isLocked) // 잠금 시 입력 불가
                        .padding()
                        .background(Color(hex: 0xE5E8F5))
                        .cornerRadius(16)
                        .font(.system(size: 24))
                        .padding()
                    
                    // 로그인 버튼
                    Button(action: {
                        handleLogin() // 로그인 로직 실행
                    }) {
                        Text("Login")
                            .foregroundColor(.white)
                            .font(.system(size: 24, weight: .bold))
                            .frame(maxWidth: .infinity, minHeight: 50)
                            .background(isLocked ? Color.gray : Color(hex:0x617AFA)) // 잠금 시 회색 처리
                            .foregroundStyle(.white)
                            .cornerRadius(12)
                    }
                    .disabled(isLocked) // 잠금 시 버튼 비활성화
                    .padding()
                    
                    // 로그인 성공 시 EditProfileView로 이동, 나중에 Main으로 변경, RoutesListView도 확인가능
                    NavigationLink("", destination: EditProfileView(), isActive: $isLoggedIn)
                        .hidden()
                    
                    Spacer()
                    
                    // 회원가입 이동 버튼
                    HStack {
                        Spacer()
                        Text("Don't have an account?")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.gray)
                        
                        NavigationLink(destination: SignUpView()) {
                            Text("Sign Up")
                                .foregroundColor(.blue)
                                .font(.system(size: 18, weight: .bold))
                        }
                        Spacer()
                    }
                    .padding(.top, 20)
                    
                }
                // 알림창 표시
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("알림"),
                        message: Text(alertMessage),
                        dismissButton: .default(Text("확인")) {
                            // "로그인 성공!"일 때 화면 이동 트리거
                            if alertMessage == "로그인 성공!" {
                                isLoggedIn = true
                            }
                        }
                    )
                }
            }
            .navigationBarHidden(true) // 네비게이션바 숨김
        }
    } // body
    
    // MARK: - Functions
    
    /// 로그인 처리 함수
    func handleLogin() {
        // 이메일 형식 검증
        if !isValidEmail(email) {
            errorCount += 1
            handleErrorLock("올바른 이메일 형식을 입력해주세요. 오류 3회시 입력이 차단됩니다.")
            return
        }
        
        // 비밀번호에 따옴표 포함 시 차단, SQL injection 방어
        if password.contains("\"") || password.contains("'") {
            errorCount += 1
            handleErrorLock("비밀번호에 따옴표는 사용할 수 없습니다. 오류 3회시 입력이 차단됩니다.")
            return
        }
        
        // Firebase Authentication 로그인 시도
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                // 로그인 실패 → 실패 횟수 증가 + 알림
                errorCount += 1
                handleErrorLock("로그인 실패: \(error.localizedDescription)")
                return
            }
            // 로그인 성공 시
            if let user = result?.user {
                let savedEmail = user.email?.lowercased() ?? email.lowercased()
                // 이메일을 UserDefaults에 저장
                UserDefaults.standard.set(savedEmail, forKey: "userEmail")
                // UserDefaults.standard.set(user.uid, forKey: "userUID") // 필요시 UID 저장
            }

            // Alert 띄우기 → 확인 버튼 누르면 화면 이동
            alertMessage = "로그인 성공!"
            showAlert = true
        }
    }
    
    /// 오류 횟수 관리 및 잠금 처리
    func handleErrorLock(_ message: String) {
        if errorCount >= 3 {
            isLocked = true
            alertMessage = "입력 오류가 3회 이상 발생했습니다. 앱을 재시작하세요."
        } else {
            alertMessage = message
        }
        showAlert = true
    }
    
    /// 이메일 정규식 검증
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
} // View

#Preview {
    LoginView()
}

extension Color {
    init(hex: UInt, alpha: Double = 1.0) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 8) & 0xFF) / 255,
            blue: Double(hex & 0xFF) / 255,
            opacity: alpha
        )
    }
}
