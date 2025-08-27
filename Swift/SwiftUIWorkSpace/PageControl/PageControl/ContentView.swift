//
//  ContentView.swift
//  PageControl
//
//  Created by Jun Jong Eck on 8/7/25.
//

import SwiftUI

struct ContentView: View {
    @State var currentPage = 0
    let images = ["flower_01", "flower_02", "flower_03", "flower_04", "flower_05", "flower_06"]
    
    var body: some View {
        VStack(content: {
            TabView(selection: $currentPage, content: {
                ForEach(0..<images.count, id: \.self, content: {index in
                    VStack(content: {
                        Text(images[index])
                            .bold()
                            .font(.system(size: 25))
                            .padding()
                        
                        
                        Image(images[index])
                            .resizable()
                            .frame(width: 350, height: 500)
                            .fixedSize()
                            .clipShape(.rect(cornerRadius: 15))
                            .scaledToFit()
                    })
                    .tag(index)
                })
            })
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
            .onAppear(perform: {
                UIPageControl.appearance().currentPageIndicatorTintColor = .red
                UIPageControl.appearance().pageIndicatorTintColor = .green
            })
        })
    }// Body
}// View

#Preview {
    ContentView()
}
