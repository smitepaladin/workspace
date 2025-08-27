//
//  AddView.swift
//  CollectionView_Label
//
//  Created by Jun Jong Eck on 8/6/25.
//

import SwiftUI

struct AddView: View {
    @Binding var dataArray: [String]
    @State var newName: String = ""
    @Environment(\.dismiss) var dismiss
    @FocusState var isTextFieldFocused: Bool
    var body: some View {
        VStack {
            HStack(content: {
                Text("인물 : ")
                
                TextField("", text: $newName)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 200)
                    .multilineTextAlignment(.leading)
                    .keyboardType(.default)
                    .focused($isTextFieldFocused)
            })
            .padding()
            
            Button("Add", action: {
                dataArray.append(newName)
                newName = ""
                isTextFieldFocused = false
                dismiss()
            })
        }
        .navigationTitle("인물 추가")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    AddView(dataArray:.constant([]))
}
