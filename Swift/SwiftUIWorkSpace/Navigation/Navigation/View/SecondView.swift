//
//  SecondView.swift
//  Navigation
//
//  Created by Jun Jong Eck on 8/6/25.
//

import SwiftUI

struct SecondView: View {
        
    @Binding var sharedData: String
    @Binding var sharedLampStatus: String
    @FocusState var isTextFieldFocused: Bool
    @State var toggleLabel = "On"
    @State var toggleStatus = true
    
    var body: some View {
        VStack(content: {
            HStack {
                Text("Message")
                
                TextField("", text: $sharedData)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 200)
                    .multilineTextAlignment(.leading)
                    .keyboardType(.default)
                    .focused($isTextFieldFocused)
                
            }
            
            HStack(content: {
                
                Spacer()
                
                Text(toggleLabel)
                
                Toggle("", isOn: $toggleStatus)
                    .labelsHidden()
                    .padding()
                    .onChange(of: toggleStatus, {
                        if toggleStatus{
                            toggleLabel = "On"
                            sharedLampStatus = "lamp_on"
                        }else{
                            toggleLabel = "Off"
                            sharedLampStatus = "lamp_off"
                        }
                    })
            })
            
        }) // VStack
        .navigationTitle("Second View")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(perform: {
            toggleLabel = sharedLampStatus == "lamp_on" ? "On" : "Off"
            toggleStatus = sharedLampStatus == "lamp_on" ? true : false
        })
    }// Body
}// View

// 전 화면에서 전달된 sharedData와 sharedLampStatus에 임시적인 값을 구성하여 Preview를 구성한다.
#Preview {
    SecondView(sharedData: .constant(""), sharedLampStatus: .constant("lamp_on"))
}
