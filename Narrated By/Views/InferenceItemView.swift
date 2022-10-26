//
//  InferenceItemView.swift
//  Narrated By
//
//  Created by Mateusz Grabara on 22/10/2022.
//

import SwiftUI
import AVKit
import Combine

struct InferenceItemView: View {
    @ObservedObject var job: FYJobDetails
    @State private var audioPlayer: AVPlayer!
    @State private var playIcon = "play.circle.fill"
    let narrateService: FakeYouService

    var body: some View {
        VStack {
            HStack {
                VStack {
                    Text(job.selectedVoice.title)
                    Text(getFirstCharacters(str: job.inferenceText, numberOfCharacters: 150))
                }
                if job.jobStatus != .completeSuccess {
                    Image(systemName: getStatusIcon(jobStatus: job.jobStatus)).resizable()
                        .aspectRatio(contentMode: .fit)
                }
            }
            HStack {
                Button(action: {
                    narrateService.submittedJobs.removeAll(where: { filteredJob in filteredJob == job })
                }) {
                    Image(systemName: "trash").resizable()
                        .aspectRatio(contentMode: .fit)
                }
                if job.jobStatus == .completeSuccess {
                    Button(action: {
                        if audioPlayer == nil {
                            preparePlayer(url: job.inferenceURL!)
                        } else {
                            playPauseAudio()
                        }
                    }) {
                        Image(systemName: playIcon).resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                    .frame(height: 50)
                    Spacer()
                        .frame(width: 50)
                    Button(action: {
                        stopAudio()
                    }) {
                        Image(systemName: "stop.circle.fill").resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                    .frame(height: 50)
                }
            }
        }
        .frame(height: 70)
    }
    
    private func getFirstCharacters(str: String, numberOfCharacters: Int) -> String {
        if str.count <= numberOfCharacters {
            return str
        }
        let index = str.index(str.startIndex, offsetBy: numberOfCharacters-3)
        return String(str[..<index]) + "..."
    }
    
    private func preparePlayer(url: URL) {
        // need to set up a session to work on mobile
        #if os(iOS)
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playback)
        } catch let error as NSError {
            print(error.description)
        }
        #endif
        
        Task(priority: .medium) {
            audioPlayer = AVPlayer(url: url)
            do {
                var times = [NSValue]()
                let duration = try await audioPlayer.currentItem!.asset.load(.duration)
                let timeMark = CMTimeMultiplyByFloat64(duration, multiplier: 1)
                times.append(NSValue(time: timeMark))
                audioPlayer.addBoundaryTimeObserver(forTimes: times, queue: .main) {
                    stopAudio()
                }
                playPauseAudio()
            } catch {
                print(error)
            }
        }
    }
    
    private func playPauseAudio() {
        if audioPlayer.timeControlStatus == .playing {
            audioPlayer.pause()
            playIcon = "play.circle.fill"
        } else {
            audioPlayer.play()
            playIcon = "pause.circle.fill"
        }
    }
    
    private func stopAudio() {
        if audioPlayer.timeControlStatus == .playing {
            audioPlayer.pause()
        }
        audioPlayer.seek(to: CMTime(seconds: .zero, preferredTimescale: 1))
        playIcon = "play.circle.fill"
    }
    
    private func getStatusIcon(jobStatus: FYJobStatusEnum) -> String {
        switch jobStatus {
        case .submitted: return "square.and.arrow.up"
        case .pending: return "hourglass"
        case .started: return "hourglass"
        case .completeSuccess: return "checkmark"
        case .completeFailure: return "exclamationmark.triangle"
        case .attemptFailed: return "exclamationmark.triangle"
        case .dead: return "exclamationmark.triangle"
        }
    }
}
