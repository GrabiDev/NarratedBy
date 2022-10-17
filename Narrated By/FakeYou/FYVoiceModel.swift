//
//  FakeYouVoiceModel.swift
//  Narrated By
//
//  Created by Mateusz Grabara on 16/10/2022.
//

import Foundation

struct FYVoiceModel: Hashable, Identifiable, Decodable {
    var id: String {modelToken}
    var modelToken: String
    var title: String
}
