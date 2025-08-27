//
//  ContentView.swift
//  Navigation
//
//  Created by Jun Jong Eck on 8/6/25.
//

import SwiftUI

struct ContentView: View {

    @State var sharedLampStatus: String = "lamp_on"
    @FocusState var isTextFieldFocused: Bool

    
    
    var body: some View {
        NavigationStack{
            VStack(content: {

                Image(sharedLampStatus)
                    .resizable()
                    .frame(width: 180, height: 300)
                    .fixedSize()
                    .padding(.bottom, 10)
                    .scaledToFit()
                

            }) // VStack
            .navigationTitle("Main Title")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing, content: {
                    NavigationLink(destination: SecondView(sharedLampStatus: $sharedLampStatus), label:{
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
