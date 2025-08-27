//
//  ContentView.swift
//  TabBarpage
//
//  Created by Jun Jong Eck on 8/6/25.
//

import SwiftUI

struct ContentView: View {
    @State var selection = 0
    var body: some View {
        TabView(selection: $selection, content: {
            FirstPage()
                .tabItem({
                    Image(systemName: "sun.max")
                    Text("Sun")
                })
                .tag(1)
            
            SecondPage()
                .tabItem({
                    Image(systemName: "sun.snow")
                    Text("Sun&Snow")
                })
                .tag(2)
        })
    } // body
} // View

#Preview {
    ContentView()
}
