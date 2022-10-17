//
//  ContentView.swift
//  Narrated By
//
//  Created by Mateusz Grabara on 15/10/2022.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var narrateService: FakeYouService
    @State private var selectedVoice: FYVoiceModel?
    @State private var textToRead = "Text to read"
    
    var body: some View {
        VStack() {
            HStack {
                VStack(alignment: .leading) {
                    Text("Narrated by")
                        .font(.title)
                    Text("Edge client for voice cloning")
                }
                Spacer()
            }
            
            
            VStack(alignment: .center) {
                if narrateService.areVoiceModelsLoaded {
                    HStack {
                        Text("Select voice: ")
                        Spacer()
                        Picker(selection: $selectedVoice, label: EmptyView()) {
                            ForEach(narrateService.voiceModels, id: \.self) {
                                voiceModel in Text(voiceModel.title)
                            }
                        }
                        .buttonStyle(.bordered)
                    }
                    
                    TextEditor(text: $textToRead)
                        .border(.primary)
                    Button("Narrate") {
                        narrateService.narrate(text: textToRead, voice: selectedVoice!)
                    }
                    .buttonStyle(.bordered)
                    if narrateService.submittedJobs.count > 0 {
                        List {
                            ForEach(narrateService.submittedJobs) {
                                job in HStack {
                                    VStack {
                                        Text(job.selectedVoice.title)
                                        Text(job.inferenceText)
                                        Text(job.jobStatus.description)
                                    }
                                    Spacer()
                                    if job.jobStatus == .completeSuccess {
                                        Button(action: {
                                            
                                        }) {
                                            Image(systemName: "play.circle.fill").resizable()
                                                .frame(width: 50, height: 50)
                                                .aspectRatio(contentMode: .fit)
                                        }
                                        Button(action: {
                                            
                                        }) {
                                            Image(systemName: "pause.circle.fill").resizable()
                                                .frame(width: 50, height: 50)
                                                .aspectRatio(contentMode: .fit)
                                        }
                                        Button(action: {
                                            
                                        }) {
                                            Image(systemName: "stop.circle.fill").resizable()
                                                .frame(width: 50, height: 50)
                                                .aspectRatio(contentMode: .fit)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                else {
                    Spacer()
                }
            }
            
        }
        .padding(10.0)
        .frame(minWidth: 300, minHeight: 300)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(FakeYouService())
    }
}
