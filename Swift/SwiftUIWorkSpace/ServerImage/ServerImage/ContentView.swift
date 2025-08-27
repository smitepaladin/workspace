//
//  ContentView.swift
//  ServerImage
//
//  Created by Jun Jong Eck on 8/7/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct ContentView: View {
    let imageURL = URL(string: "https://zeushahn.github.io/Test/images/dog.jpg")
    @State var isButtonClicked: Bool = false
    
    var body: some View {
        VStack(content: {
            Button("Load Image", action: {
                isButtonClicked.toggle()
            })
            .padding()
            
            Spacer()
            
            if isButtonClicked {
                WebImage(url: imageURL)
                    .resizable()
                    .frame(width: 300, height: 250)
                    .clipShape(.rect)
                    .shadow(radius: 20)
            }
            
            Spacer()
        })
    }// Body
}// View

#Preview {
    ContentView()
}
