//
//  FYJobStatus.swift
//  Narrated By
//
//  Created by Mateusz Grabara on 17/10/2022.
//

enum FYJobStatus {
    case submitted
    case pending
    case started
    case completeSuccess
    case completeFailure
    case attemptFailed
    case dead
    
    var description: String {
        switch self {
        case .submitted: return "Submitted"
        case .pending: return "Pending"
        case .started: return "Started"
        case .completeSuccess: return "Completed"
        case .completeFailure: return "Failed"
        case .attemptFailed: return "Attempt failed"
        case .dead: return "Aborted"
        }
    }
}
