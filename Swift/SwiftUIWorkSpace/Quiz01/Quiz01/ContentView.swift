//
//  ContentView.swift
//  Computer
//
//  Created by Jun Jong Eck on 8/1/25.
//

import SwiftUI

struct ContentView: View {
    // Property
    @State var productName = false

    var body: some View {
        VStack(content: {
            Spacer()

            Text(productName ? "Welcome! SmitePaladin" : "Welcome!")

            Spacer()
            
            Button("Name", action: {
                productName.toggle()
            })
        })
        .padding()
    } // body
} // ContentView

#Preview {
    ContentView()
}
