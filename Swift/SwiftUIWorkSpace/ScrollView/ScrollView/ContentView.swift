//
//  ContentView.swift
//  ScrollView
//
//  Created by Jun Jong Eck on 8/7/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(content: {
            Text("Scroll View")
                .bold()
                .font(.largeTitle)
            
            ScrollView(.vertical, content: {
                VStack(spacing: 10, content: {
                    ForEach(1...20, id:\.self, content:{index in
                        Text("Row \(index)")
                            .font(.callout)
                            .foregroundColor(.blue)
                            .padding()
                    })
                })
                .frame(maxWidth: .infinity)
            })
        })
        
    }// Body
}// View

#Preview {
    ContentView()
}
