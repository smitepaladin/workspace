//
//  ContentView.swift
//  Navigation01
//
//  Created by Jun Jong Eck on 8/6/25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var lampData: LampData
    @FocusState var isTextFieldFocused: Bool
    @State var message = ""
    
    
    var body: some View {
        NavigationStack{
            VStack(content: {
                Image(lampData.sharedLampStatus)
                    .resizable()
                    .frame(width: 180, height: 300)
                    .fixedSize()
                    .padding(.bottom, 10)
                    .scaledToFit()
                
                HStack(content: {
                    Text("Message")
                    
                    TextField("", text: $lampData.sharedData)
                        .textFieldStyle(.roundedBorder)
                        .frame(width :200)
                        .multilineTextAlignment(.leading)
                        .keyboardType(.default)
                        .focused($isTextFieldFocused)
                    
                    // ---->
                    NavigationLink(destination: SecondView(), label:{
                            Text("수정")
                    })
                    .padding()
                }) // HStack
            }) // VStack
            .navigationTitle("Main Title")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing, content: {
                    NavigationLink(destination: SecondView(), label:{
                            Image(systemName: "lightbulb.led")
                    })
                })
            })
            // NavigationStack에 쓰는것이 아니라 Vstack에 쓴다.
        }// NavigationStack
    }// Body
}// View

#Preview {
    ContentView().environmentObject(LampData())
}
