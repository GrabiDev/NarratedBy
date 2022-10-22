//
//  FYJobStatusEnum.swift
//  Narrated By
//
//  Created by Mateusz Grabara on 17/10/2022.
//

enum FYJobStatusEnum: String, Decodable {
    case submitted = "submitted"
    case pending = "pending"
    case started = "started"
    case completeSuccess = "complete_success"
    case completeFailure = "complete_failure"
    case attemptFailed = "attempt_failed"
    case dead = "dead"
    
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
