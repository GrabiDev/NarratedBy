//
//  Narrated_ByApp.swift
//  Narrated By
//
//  Created by Mateusz Grabara on 15/10/2022.
//

import SwiftUI

@main
struct Narrated_ByApp: App {
    @StateObject private var fyService = FakeYouService()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(fyService)
        }
    }
}
