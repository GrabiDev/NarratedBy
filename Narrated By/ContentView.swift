//
//  ContentView.swift
//  Narrated By
//
//  Created by Mateusz Grabara on 15/10/2022.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var narrateService: FakeYouService
    
    var body: some View {
        VStack() {
            HStack {
                VStack(alignment: .leading) {
                    Text("Narrated by")
                        .font(.title)
                    Text("Edge client for voice cloning")
                }
                Spacer()
            }
            
            
            VStack(alignment: .center) {
                if !narrateService.voiceModels.isEmpty {
                    SubmitInferenceView()
                }
                if !narrateService.submittedJobs.isEmpty {
                    PlayInferenceView()
                }
                else {
                    Spacer()
                }
            }
            
        }
        .padding(10.0)
        .frame(minWidth: 300, minHeight: 600)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(FakeYouService())
    }
}
