//
//  TtsRequest.swift
//  Narrated By
//
//  Created by Mateusz Grabara on 16/10/2022.
//

import Foundation

struct FYTtsRequest: Encodable {
    let uuidIdempotencyToken = UUID().uuidString
    
    var ttsModelToken: String
    var inferenceText: String
}
