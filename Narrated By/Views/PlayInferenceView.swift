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
        GroupBox {
            ForEach(narrateService.submittedJobs, id: \.self) {
                job in InferenceItemView(job: job)
            }
        }
        .frame(minHeight: 300, alignment: .top)
    }
}
