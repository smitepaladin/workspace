//
//  ContentView.swift
//  Computer
//
//  Created by Jun Jong Eck on 8/1/25.
//

import SwiftUI

struct ContentView: View {
    // Property
    @State var productName = ""

    var body: some View {
        

            Spacer()
                
            HStack(spacing: 10, content: { // HStack 안에 공백
                Text("Welcome!\(productName)")
            })

            Spacer()
            
            HStack(spacing: 10, content: { // HStack 안에 공백
                
                // Name Button
                Button("Name", action: {
                    let productName_T: String = "SmitePaladin"
                     productName = productName_T
                })
                .padding()

                
                // Clear button
                Button("Clear", action: {
                    productName.removeAll()
                })
            })
            .padding()
           
            

        
            
 

    } // body
} // ContentView

#Preview {
    ContentView()
}
