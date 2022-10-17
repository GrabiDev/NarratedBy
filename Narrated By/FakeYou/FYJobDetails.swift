//
//  FYJobDetails.swift
//  Narrated By
//
//  Created by Mateusz Grabara on 17/10/2022.
//

struct FYJobDetails: Identifiable {
    var id: String {inferenceJobToken}
    let inferenceJobToken: String
    let inferenceText: String
    let selectedVoice: FYVoiceModel
    let jobStatus: FYJobStatus
}
