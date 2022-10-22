//
//  FYJobDetails.swift
//  Narrated By
//
//  Created by Mateusz Grabara on 17/10/2022.
//

import Foundation

class FYJobDetails: ObservableObject, Hashable {
    static func == (lhs: FYJobDetails, rhs: FYJobDetails) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    var id: String {inferenceJobToken}
    let inferenceJobToken: String
    let inferenceText: String
    let selectedVoice: FYVoiceModel
    @Published var jobStatus: String
    @Published var inferenceURL: URL?
    
    init(inferenceJobToken: String, inferenceText: String, selectedVoice: FYVoiceModel, jobStatus: String?, inferenceURL: URL?) {
        if jobStatus == nil {
            self.jobStatus = "submitted"
        } else {
            self.jobStatus = jobStatus!
        }
        
        self.inferenceJobToken = inferenceJobToken
        self.inferenceText = inferenceText
        self.selectedVoice = selectedVoice
        
        if inferenceURL != nil {
            self.inferenceURL = inferenceURL
        }
    }
}
