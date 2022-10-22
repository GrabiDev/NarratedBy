//
//  FYJobStatus.swift
//  Narrated By
//
//  Created by Mateusz Grabara on 17/10/2022.
//

struct FYJobStatus: Decodable {
    var jobToken: String
    var status: String
    var maybePublicBucketWavAudioPath: String?
}
