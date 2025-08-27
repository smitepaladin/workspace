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
            Group {
                FirstPage()
                    .tabItem({
                        Image(systemName: "house.fill")
                        Text("Image")
                    })
                    .tag(0)
                
                SecondPage()
                    .tabItem({
                        Image(systemName: "car.fill")
                        Text("Image")
                    })
                    .tag(1)
                
                ThirdPage()
                    .tabItem({
                        Image(systemName: "person.fill")
                        Text("Date")
                    })
                    .tag(2)
            }
            .accentColor(.white)
            .padding()
            .toolbarBackground(.yellow, for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
//            .toolbarBackground(.dark, for: .tabBar)
            

            

        })
    } // body
} // View

#Preview {
    ContentView()
}
