//
//  InferenceItemView.swift
//  Narrated By
//
//  Created by Mateusz Grabara on 22/10/2022.
//

import SwiftUI
import AVKit

struct InferenceItemView: View {
    @ObservedObject var job: FYJobDetails
    @State var audioPlayer: AVAudioPlayer!
    
    var body: some View {
        HStack {
            VStack {
                Text(job.selectedVoice.title)
                Text(job.inferenceText)
                Text(job.jobStatus)
            }
            Spacer()
            if job.jobStatus == "complete_success" {
                Button(action: {
                    self.audioPlayer = try! AVAudioPlayer(contentsOf: job.inferenceURL!)
                    self.audioPlayer.play()
                }) {
                    Image(systemName: "play.circle.fill").resizable()
                        .frame(width: 50, height: 50)
                        .aspectRatio(contentMode: .fit)
                }
                Button(action: {
                    self.audioPlayer.pause()
                }) {
                    Image(systemName: "pause.circle.fill").resizable()
                        .frame(width: 50, height: 50)
                        .aspectRatio(contentMode: .fit)
                }
                Button(action: {
                    self.audioPlayer.stop()
                }) {
                    Image(systemName: "stop.circle.fill").resizable()
                        .frame(width: 50, height: 50)
                        .aspectRatio(contentMode: .fit)
                }
            }
        }
    }
}
