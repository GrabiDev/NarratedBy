//
//  FYJobDetails.swift
//  Narrated By
//
//  Created by Mateusz Grabara on 17/10/2022.
//

import Foundation

class FYJobDetails: ObservableObject, Hashable, Codable {
    var id: String {inferenceJobToken}
    let inferenceJobToken: String
    let inferenceText: String
    let selectedVoice: FYVoiceModel
    @Published var jobStatus: FYJobStatusEnum
    @Published var inferenceURL: URL?
    
    static func == (lhs: FYJobDetails, rhs: FYJobDetails) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    private enum CodingKeys: String, CodingKey {
        case inferenceJobToken, inferenceText, selectedVoice, jobStatus, inferenceURL
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(inferenceJobToken, forKey: .inferenceJobToken)
        try container.encode(inferenceText, forKey: .inferenceText)
        try container.encode(selectedVoice, forKey: .selectedVoice)
        try container.encode(jobStatus, forKey: .jobStatus)
        try container.encode(inferenceURL?.absoluteString, forKey: .inferenceURL)
    }
    
    init(inferenceJobToken: String, inferenceText: String, selectedVoice: FYVoiceModel, jobStatus: FYJobStatusEnum?, inferenceURL: URL?) {
        if jobStatus == nil {
            self.jobStatus = .submitted
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
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        inferenceJobToken = try container.decode(String.self, forKey: .inferenceJobToken)
        inferenceText = try container.decode(String.self, forKey: .inferenceText)
        selectedVoice = try container.decode(FYVoiceModel.self, forKey: .selectedVoice)
        jobStatus = try container.decode(FYJobStatusEnum.self, forKey: .jobStatus)
        let inferenceURLStr = try container.decode(String.self, forKey: .inferenceURL)
        inferenceURL = URL(string: inferenceURLStr)
    }
}
