//
//  ContentView.swift
//  MultiLine
//
//  Created by Jun Jong Eck on 8/4/25.
//

import SwiftUI

struct ContentView: View {
    @FocusState var isTextFieldFocused: Bool
    @State var inputText = ""
    @State var enteredText = ""

    var body: some View {
        VStack(content: {
            Text("구구단 출력")
                .bold(true)
                .padding()
            
            HStack(content: {
                TextField("구구단", text: $inputText)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 200)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.numberPad)
                    .focused($isTextFieldFocused)
                
                Button("단출력", action: {
                    enteredText = ""
                    let textCheck = inputText.trimmingCharacters(in: .whitespacesAndNewlines)
                    
                    if let dan = Int(textCheck), dan >= 2 && dan <= 9 {
                        // 구구단 출력
                        for i in 1...9 {
                            enteredText += "\(dan) x \(i) = \(dan * i)\n"
                        }
                    } else {
                        // 잘못된 입력 처리
                        enteredText += "2~9 사이 숫자를 입력하세요.\n"
                    }
                    
                    
                    inputText = ""
                    isTextFieldFocused = false
                })
            })
            
            TextEditor(text: $enteredText)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .foregroundStyle(.black).bold(true)
                .colorMultiply(.gray.opacity(1))
                .clipShape(.rect(cornerRadius: 15))
                .disabled(true)
                .padding()
                .font(.system(size: 30))
        })
        .padding()
    }// body
    
    
}//View

#Preview {
    ContentView()
}

