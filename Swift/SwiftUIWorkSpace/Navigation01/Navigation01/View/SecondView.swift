//
//  SecondView.swift
//  Navigation01
//
//  Created by Jun Jong Eck on 8/6/25.
//

import SwiftUI

struct SecondView: View {
    @EnvironmentObject var lampData: LampData
    @FocusState var isTextfieldFocused: Bool
    @State var toggleLabel = "On"
    @State var toggleStatus = true
    
    
    
    
    var body: some View {
        VStack(content: {
            HStack {
                Text("Message")
                
                TextField("", text: $lampData.sharedData)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 200)
                    .multilineTextAlignment(.leading)
                    .keyboardType(.default)
                    .focused($isTextfieldFocused)
            }
            
            HStack(content: {
                
                Spacer()
                
                Text(toggleLabel)
                
                Toggle("", isOn: $toggleStatus)
                    .labelsHidden()
                    .padding()
                    .onChange(of: toggleStatus) {
                        if toggleStatus {
                            toggleLabel = "On"
                            lampData.sharedLampStatus = "lamp_on"
                        }else{
                            toggleLabel = "Off"
                            lampData.sharedLampStatus = "lamp_off"
                        }
                        
                    }
            })
        })
        .navigationTitle("Second View")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(perform: {
            toggleLabel = lampData.sharedLampStatus == "lamp_on" ? "On" : "Off"
            toggleStatus = lampData.sharedLampStatus == "lamp_on" ? true : false
        })
        
    }
}

 // 전 화면에서 전달된 sharedData와 sharedLampStatus에 임시적인 값을 구성하여 Preview를 구성한다.
#Preview {
    SecondView().environmentObject(LampData())
}
