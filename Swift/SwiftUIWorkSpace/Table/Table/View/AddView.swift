//
//  AddView.swift
//  Table
//
//  Created by Jun Jong Eck on 8/6/25.
//
import SwiftUI

struct AddView: View {
    
    @State var newItem: String = ""
    @FocusState var isTextFieldFocused: Bool
    @Binding var todoList: [TodoList]
    @Environment(\.dismiss) var dismiss
    @State var selectedImage: Int = 0
    let imageFileName = ["cart", "clock", "pencil"]
    
    var body: some View {
        VStack(content: {
            
            HStack {
                Image(imageFileName[selectedImage])
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .clipShape(.rect(cornerRadius: 15))
                    .padding()

                Picker("", selection: $selectedImage) {
                    ForEach(0..<imageFileName.count, id: \.self) { index in
                        Image(imageFileName[index])
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                    }
                }
                .pickerStyle(.wheel)
                .frame(width: 120)
                .clipped()
            }
            
            
            HStack(content: {
                Text("항목 :")
                
                TextField("", text:$newItem)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 200)
                    .multilineTextAlignment(.leading)
                    .keyboardType(.default)
                    .focused($isTextFieldFocused)
                
            })
            .padding()
            
            Button("Add", action: {
                todoList.append(TodoList(items: newItem, itemsImageFile: imageFileName[selectedImage]))
                newItem = ""
                isTextFieldFocused = false
                dismiss()
            })
        })
        .navigationTitle("Add View")
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

#Preview {
    AddView(todoList: .constant([]))
}
