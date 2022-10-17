//
//  FakeYouVoicesDTO.swift
//  Narrated By
//
//  Created by Mateusz Grabara on 16/10/2022.
//

import Foundation

struct FYVoicesDTO: Decodable {
    var success: Bool
    var models: [FYVoiceModel]
}
