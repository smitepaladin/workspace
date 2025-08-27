//
//  SecondView.swift
//  Quiz15
//
//  Created by Jun Jong Eck on 8/6/25.
//
import SwiftUI

struct SecondView: View {
        
    @Binding var sharedLampStatus: String
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
                            sharedLampStatus = "lamp_on"
                        }else{
                            toggleLabel = "Off"
                            sharedLampStatus = "lamp_off"
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
                                sharedLampStatus = "lamp_on"
                            } else {
                                toggleColorLabel = "Red"
                                sharedLampStatus = "lamp_red"
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
            switch sharedLampStatus {
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

// 전 화면에서 전달된 sharedData와 sharedLampStatus에 임시적인 값을 구성하여 Preview를 구성한다.
#Preview {
    SecondView(sharedLampStatus: .constant("lamp_on"))
}
