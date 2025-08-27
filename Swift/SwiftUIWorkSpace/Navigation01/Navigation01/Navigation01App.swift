//
//  Navigation01App.swift
//  Navigation01
//
//  Created by Jun Jong Eck on 8/6/25.
//

import SwiftUI

@main
struct Navigation01App: App {
    @StateObject private var lampData = LampData()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(lampData)
        }
    }
}
