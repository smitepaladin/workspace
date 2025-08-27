//
//  SecondView.swift
//  Quiz15model
//
//  Created by Jun Jong Eck on 8/6/25.
//

import SwiftUI

struct SecondView: View {
        
    @EnvironmentObject var lampData: LampData
    @FocusState var isTextFieldFocused: Bool
    @State var toggleLabel = "On"
    @State var toggleColorLabel = "Yellow"
    @State var toggleColorStatus = true
    @State var toggleStatus = true
    
    var body: some View {
        VStack(content: {

            
            HStack(content: {
                
 
                
                Text(toggleLabel)
                
                Toggle("", isOn: $toggleStatus)
                    .labelsHidden()
                    .padding()
                    .onChange(of: toggleStatus, {
                        if toggleStatus{
                            toggleLabel = "On"
                            lampData.sharedLampStatus = "lamp_on"
                        }else{
                            toggleLabel = "Off"
                            lampData.sharedLampStatus = "lamp_off"
                        }
                    })
            })
            
            HStack(content: {
                
 
                
                Text(toggleColorLabel)
                
                Toggle("", isOn: $toggleColorStatus)
                    .labelsHidden()
                    .padding()
                    .onChange(of: toggleColorStatus, {
                        if toggleStatus {
                            if toggleColorStatus {
                                toggleColorLabel = "Yellow"
                                lampData.sharedLampStatus = "lamp_on"
                            } else {
                                toggleColorLabel = "Red"
                                lampData.sharedLampStatus = "lamp_red"
                            }
                        } else {
                            // OFF 상태에서는 색상 변경만 반영하고 sharedLampStatus는 유지
                            toggleColorLabel = toggleColorStatus ? "Yellow" : "Red"
                        }
                    })
            })
            
            
        }) // VStack
        .navigationTitle("Second View")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            switch lampData.sharedLampStatus {
            case "lamp_on":
                toggleLabel = "On"
                toggleStatus = true
                toggleColorLabel = "Yellow"
                toggleColorStatus = true

            case "lamp_red":
                toggleLabel = "On"
                toggleStatus = true
                toggleColorLabel = "Red"
                toggleColorStatus = false

            case "lamp_off":
                toggleLabel = "Off"
                toggleStatus = false

            default:
                break
            }
        }
    }// Body
}// View


#Preview {
    SecondView().environmentObject(LampData())
}
