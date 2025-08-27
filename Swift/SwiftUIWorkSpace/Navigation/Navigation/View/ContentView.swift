//
//  ContentView.swift
//  Navigation
//
//  Created by Jun Jong Eck on 8/6/25.
//

import SwiftUI

struct ContentView: View {
    @State var sharedData : String = ""
    @State var sharedLampStatus: String = "lamp_on"
    @FocusState var isTextFieldFocused: Bool
    @State var message = ""
    
    
    var body: some View {
        NavigationStack{
            VStack(content: {
                Image(sharedLampStatus)
                    .resizable()
                    .frame(width: 180, height: 300)
                    .fixedSize()
                    .padding(.bottom, 10)
                    .scaledToFit()
                
                HStack(content: {
                    Text("Message")
                    
                    TextField("", text: $sharedData)
                        .textFieldStyle(.roundedBorder)
                        .frame(width :200)
                        .multilineTextAlignment(.leading)
                        .keyboardType(.default)
                        .focused($isTextFieldFocused)
                    
                    // ---->
                    NavigationLink(destination: SecondView(sharedData: $sharedData, sharedLampStatus: $sharedLampStatus), label:{
                            Text("수정")
                    })
                    .padding()
                }) // HStack
            }) // VStack
            .navigationTitle("Main Title")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing, content: {
                    NavigationLink(destination: SecondView(sharedData: $sharedData, sharedLampStatus: $sharedLampStatus), label:{
                            Image(systemName: "lightbulb.led")
                    })
                })
            })
            // NavigationStack에 쓰는것이 아니라 Vstack에 쓴다.
        }// NavigationStack
    }// Body
}// View

#Preview {
    ContentView()
}
