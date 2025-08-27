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
                Text(productName)
                    .font(.title)
                    .multilineTextAlignment(.center)
            })

            Spacer()
            
            HStack(spacing: 10, content: { // HStack 안에 공백
                
                
                Button("😀", action: {
                    productName += "😀"
                })
                .frame(width:50, height: 50)
                .border(.blue, width:1)
                
                
                Button("🥰", action: {
                    productName += "🥰"
                })
                .frame(width:50, height: 50)
                .border(.blue, width:1)

                

                Button("😎", action: {
                    productName += "😎"
                })
                .frame(width:50, height: 50)
                .border(.blue, width:1)
            })
            .padding()

           
            

        
            
 

    } // body
} // ContentView

#Preview {
    ContentView()
}
