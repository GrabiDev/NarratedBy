//
//  PlayInferenceView.swift
//  Narrated By
//
//  Created by Mateusz Grabara on 17/10/2022.
//

import SwiftUI
import AVKit

struct PlayInferenceView: View {
    @EnvironmentObject var narrateService: FakeYouService
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(narrateService.submittedJobs, id: \.self) {
                    job in InferenceItemView(job: job, narrateService: narrateService)
                }
            }
        }
    }
}
