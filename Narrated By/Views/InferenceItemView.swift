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

    var body: some View {
        HStack {
            VStack {
                Text(job.selectedVoice.title)
                Text(getFirstCharacters(str: job.inferenceText, numberOfCharacters: 150))
                Text(job.jobStatus)
            }
            if job.jobStatus == "complete_success" {
                Button(action: {
                    if audioPlayer == nil {
                        preparePlayer(url: job.inferenceURL!)
                    }
                    if audioPlayer.timeControlStatus == .playing {
                        audioPlayer.pause()
                        playIcon = "play.circle.fill"
                    } else {
                        audioPlayer.play()
                        playIcon = "pause.circle.fill"
                    }
                }) {
                    Image(systemName: playIcon).resizable()
                        .aspectRatio(contentMode: .fit)
                }
                Button(action: {
                    audioPlayer.pause()
                    audioPlayer.seek(to: CMTime(seconds: .zero, preferredTimescale: 1))
                    playIcon = "play.circle.fill"
                }) {
                    Image(systemName: "stop.circle.fill").resizable()
                        .aspectRatio(contentMode: .fit)
                }
            }
        }
    }
    
    private func getFirstCharacters(str: String, numberOfCharacters: Int) -> String {
        if str.count <= numberOfCharacters {
            return str
        }
        let index = str.index(str.startIndex, offsetBy: numberOfCharacters-3)
        return String(str[..<index]) + "..."
    }
    
    private func preparePlayer(url: URL) {
        audioPlayer = AVPlayer(url: url)
        audioPlayer.addObserver(self, forKeyPath: "timeControlStatus", context: nil) {
            
        }
    }
}
