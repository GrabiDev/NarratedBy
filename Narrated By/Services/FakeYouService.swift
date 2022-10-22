//
//  FakeYouService.swift
//  Narrated By
//
//  Created by Mateusz Grabara on 16/10/2022.
//

import Foundation
import Combine

final class FakeYouService: ObservableObject {
    @Published var voiceModels: [FYVoiceModel] = []
    @Published var submittedJobs: [FYJobDetails] = []
    
    private let FAKE_YOU_URL = "https://api.fakeyou.com/tts/"
    
    init() {
        fetchVoices()
        startPolling()
    }
    
    func narrate(text: String, voice: FYVoiceModel) {
        let ttsRequest = FYTtsRequest(ttsModelToken: voice.id, inferenceText: text)
        
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        guard let requestBody = try? encoder.encode(ttsRequest) else {
            fatalError("JSON encoding error")
        }
        
        let endpointUrl = URL(string: FAKE_YOU_URL + "inference")!
        var request = URLRequest(url: endpointUrl)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let completionHandler: (Data?, URLResponse?, Error?) -> Void = { data, response, error in
            if let error = error {
                fatalError("\(error)")
            }
            guard let response = response as? HTTPURLResponse,
                (200...299).contains(response.statusCode) else {
                fatalError("server error")
            }
            if let mimeType = response.mimeType,
                mimeType == "application/json",
                let data = data,
                let response = try? decoder.decode(FYTtsResponseDTO.self, from: data) {
                DispatchQueue.main.async {
                    let jobDetails = FYJobDetails(inferenceJobToken: response.inferenceJobToken, inferenceText: text, selectedVoice: voice, jobStatus: "s", inferenceURL: nil)
                    self.submittedJobs.append(jobDetails)
                }
            }
        }
        let task = URLSession.shared.uploadTask(with: request, from: requestBody, completionHandler: completionHandler)
        task.resume()
    }
    
    func fetchVoices() {
        let endpointUrl = URL(string: FAKE_YOU_URL + "list")!
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        var request = URLRequest(url: endpointUrl)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let completionHandler: (Data?, URLResponse?, Error?) -> Void = {
            (data, response, error) in
            if let error = error {
                fatalError("error: \(error)")
            }
            guard let response = response as? HTTPURLResponse,
                (200...299).contains(response.statusCode) else {
                fatalError("Server error")
            }
            if let mimeType = response.mimeType, mimeType == "application/json",
                        let data = data,
                        let fakeYouVoiceDTO = try? decoder.decode(FYVoicesDTO.self, from: data) {
                            DispatchQueue.main.async {
                                self.voiceModels = fakeYouVoiceDTO.models
                            }
                        }
        }
        let task = URLSession.shared.dataTask(with: request, completionHandler: completionHandler)
        task.resume()
    }
    
    func updateJobStatuses() {
        let AUDIO_URL = "https://storage.googleapis.com/vocodes-public"
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        for job in submittedJobs {
            if job.inferenceURL != nil {
                continue
            }
            let endpointUrl = URL(string: FAKE_YOU_URL + "job/" + job.inferenceJobToken)!
            
            var request = URLRequest(url: endpointUrl)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            
            let completionHandler: (Data?, URLResponse?, Error?) -> Void = {
                (data, response, error) in
                if let error = error {
                    fatalError("error: \(error)")
                }
                guard let response = response as? HTTPURLResponse,
                    (200...299).contains(response.statusCode) else {
                    fatalError("Server error")
                }
                if let mimeType = response.mimeType, mimeType == "application/json",
                   let data = data,
                   let jobStatusDTO = try? decoder.decode(FYJobStatusDTO.self, from: data) {
                       let jobState = jobStatusDTO.state
                       job.jobStatus = jobState.status
                    if jobState.status == "complete_success" && jobState.maybePublicBucketWavAudioPath != nil {
                        job.inferenceURL = URL(string: AUDIO_URL + jobState.maybePublicBucketWavAudioPath!)
                        }
                   }
            }
            let task = URLSession.shared.dataTask(with: request, completionHandler: completionHandler)
            task.resume()
        }
    }
    
    func startPolling() {
        let timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { timer in
            self.updateJobStatuses()
        }
        timer.fire()
    }
}
