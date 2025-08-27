//
//  Message.swift
//  running
//
//  Created by Sua Kim on 8/20/25.
//
import SwiftUI

// 1) Message 모델
struct Message: Identifiable, Hashable {
    let id = UUID()
    let text: String
    let isMe: Bool
    let time: Date = Date()
}

// 2) ViewModel
@MainActor
final class ChatViewModel: ObservableObject {
    @Published var messages: [Message] = []

    func send(_ text: String, isMe: Bool) {
        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        messages.append(Message(text: trimmed, isMe: isMe))
    }
}


// 3) 말풍선 뷰
struct MessageBubble: View {
    let message: Message

    var body: some View {
        HStack {
            if message.isMe { Spacer(minLength: 40) } // 내 메시지면 오른쪽 정렬

            VStack(alignment: message.isMe ? .trailing : .leading, spacing: 4) {
                Text(message.text)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .fill(message.isMe ? Color.blue : Color.gray.opacity(0.2))
                    )
                    .foregroundColor(message.isMe ? .white : .primary)

                Text(Self.timeString(message.time))
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }

            if !message.isMe { Spacer(minLength: 40) } // 상대 메시지면 왼쪽 정렬
        }
        .padding(.horizontal)
        .padding(.vertical, 4)
    }

    private static func timeString(_ date: Date) -> String {
        let f = DateFormatter()
        f.dateFormat = "HH:mm"
        return f.string(from: date)
    }
}

// 4) 입력 바
struct InputBar: View {
    @Binding var text: String
    var onSend: () -> Void

    var body: some View {
        HStack(spacing: 8) {
            TextField("메시지를 입력하세요", text: $text, axis: .vertical)
                .textFieldStyle(.roundedBorder)
                .lineLimit(1...4)

            Button(action: onSend) {
                Image(systemName: "paperplane.fill")
                    .font(.system(size: 18))
                    .foregroundColor(.white)
                    .padding(10)
                    .background(Circle().fill(Color.accentColor))
            }
            .disabled(text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(.ultraThinMaterial)
    }
}

// 5) 채팅 화면 (자동 스크롤 포함)
struct ChatView: View {
    @StateObject private var vm = ChatViewModel()
    @State private var draft = ""
    @State private var otherTurn = false

    var body: some View {
        VStack(spacing: 0) {
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack(spacing: 0) {
                        ForEach(vm.messages) { msg in
                            MessageBubble(message: msg)
                                .id(msg.id)
                        }
                    }
                }
                .onChange(of: vm.messages) { _ in
                    // 새 메시지 추가 시 하단으로 스크롤
                    if let last = vm.messages.last {
                        DispatchQueue.main.async {
                            withAnimation(.easeOut) {
                                proxy.scrollTo(last.id, anchor: .bottom)
                            }
                        }
                    }
                }
            }

            InputBar(text: $draft) {
                let myText = draft
                vm.send(myText, isMe: true)
                draft = ""

                // 데모용: 상대방 답장 시뮬
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                    vm.send("답장: \(myText)", isMe: false)
                }
            }
        }
        .navigationTitle("채팅")
        .navigationBarTitleDisplayMode(.inline)
    }
}


