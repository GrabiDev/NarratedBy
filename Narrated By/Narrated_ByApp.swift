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
            ContentView() {
                FakeYouService.save(jobDetails: fyService.submittedJobs) { result in
                    if case .failure(let error) = result {
                        fatalError(error.localizedDescription)
                    }
                }
            }
            .environmentObject(fyService)
            .onAppear {
                FakeYouService.load { result in
                    switch result {
                    case .failure(let error):
                        fatalError(error.localizedDescription)
                    case .success(let submittedJobs):
                        fyService.submittedJobs = submittedJobs
                    }
                }
            }
        }
    }
}
