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
            Text("보낸내용")
                .bold(true)
                .padding()
            

            
            TextEditor(text: $enteredText)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .foregroundStyle(.black).bold(true)
                .clipShape(.rect(cornerRadius: 15))
                .disabled(true)
                .padding()
                .border(.gray, width: 3)
                .font(.system(size: 20, weight: .bold))
                
        })
        .padding()
        
        Text("메세지")
        
        TextField("문자 입력", text: $inputText)
            .textFieldStyle(.roundedBorder)
            .frame(width: 200)
            .multilineTextAlignment(.leading)
            .keyboardType(.default)
            .focused($isTextFieldFocused)
        
        HStack(content: {
            
            Button("보내기", action: {
                let textCheck = inputText.trimmingCharacters(in: .whitespacesAndNewlines) //
                
                if !textCheck.isEmpty {
                    enteredText += "\(inputText)\n"
                }
                inputText = ""
                isTextFieldFocused = false
            })
            
            Button("😀", action: {
                inputText += "😀"
            })
            .frame(width:50, height: 50)
            .border(.blue, width:1)
            
            
            Button("🥰", action: {
                inputText += "🥰"
            })
            .frame(width:50, height: 50)
            .border(.blue, width:1)

            

            Button("😎", action: {
                inputText += "😎"
            })
            .frame(width:50, height: 50)
            .border(.blue, width:1)
            
        })
    }// body
}//View

#Preview {
    ContentView()
}

