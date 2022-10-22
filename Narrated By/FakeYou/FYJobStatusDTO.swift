//
//  FYJobStatusDTO.swift
//  Narrated By
//
//  Created by Mateusz Grabara on 17/10/2022.
//

struct FYJobStatusDTO: Decodable {
    var success: Bool
    var state: FYJobStatus
}
