//
//  ContentView.swift
//  Alert
//
//  Created by Jun Jong Eck on 8/6/25.
//
import SwiftUI

struct ContentView: View {
    @State var imageName: String = "lamp_on"
    @State var isOn = false
    @State var isOff = false
    @State var isRemove = false

    var body: some View {
        VStack {
            Spacer()
            
            Text("Alert")
                .bold()
            
            Image(imageName)
                .resizable()
                .frame(width: 350, height: 550)
            
            Spacer()
            
            HStack(spacing: 70) {

                Button("켜기") {
                    isOn = true
                }
                .alert(
                    imageName == "lamp_on"
                        ? "현재 On 상태입니다."
                        : "램프를 켜시겠습니까?",
                    isPresented: $isOn
                ) {
                    if imageName == "lamp_on" {
                        Button("확인", role: .cancel) {

                        }
                    } else {
                        Button("아니오", role: .cancel) {

                        }
                        Button("네") {
                            imageName = "lamp_on"
                        }
                    }
                }
                
                Button("끄기") {
                    isOff = true
                }
                .alert(
                    imageName == "lamp_off"
                        ? "현재 Off 상태입니다."
                        : "램프를 끄시겠습니까?",
                    isPresented: $isOff
                ) {

                    if imageName == "lamp_off" {
                        Button("확인", role: .cancel) {
                            //
                        }
                    } else {
                        Button("아니오", role: .cancel) {
                            //
                        }
                        Button("네") {
                            imageName = "lamp_off"
                        }
                    }
                }
                
                Button("제거") {
                    isRemove = true
                }
                .alert("램프를 제거할까요?", isPresented: $isRemove, actions: {
                    Button("아니오, 끕니다",role: .none, action: {
                        imageName = "lamp_off"
                    })
                    
                    Button("아니오, 켭니다",role: .none, action: {
                        imageName = "lamp_on"
                    })
                    
                    Button("네, 제거합니다",role: .cancel, action: {
                        imageName = "lamp_remove"
                    })
                })
            }
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
