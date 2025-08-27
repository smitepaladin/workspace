//
//  Chatting.swift
//  running
//
//  Created by Sua Kim on 8/19/25.
//

import SwiftUI

struct Chatting: View {
    @State var email: String = "" // 이메일 입력창 내용
    @State var password: String = "" // 비밀번호 입력창 내용
    @State var errorCount: Int = 0 // 틀릴 때마다 +1 3 일 때 isLocked = true
    @State var isLocked: Bool = false // true 일 때 로그인 잠금
    @State var showAlert: Bool = false // 경고창 상태
    @State var alertMessage: String = "" // 경고창 메세지
    var body: some View {
        NavigationStack {
            ChatView()
        }
    }
}

#Preview {
    Chatting()
}
