//
//  Quiz15modelApp.swift
//  Quiz15model
//
//  Created by Jun Jong Eck on 8/6/25.
//

import SwiftUI

@main
struct Quiz15modelApp: App {
    @StateObject private var lampData = LampData()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(lampData)
        }
    }
}
