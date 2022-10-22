//
//  SubmitTextView.swift
//  Narrated By
//
//  Created by Mateusz Grabara on 17/10/2022.
//

import SwiftUI

struct SubmitInferenceView: View {
    @EnvironmentObject var narrateService: FakeYouService
    @State private var selectedVoice = FYVoiceModel(modelToken: "", title: "")
    @State private var textToRead = "Text to read"
    
    var body: some View {
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
            narrateService.narrate(text: textToRead, voice: selectedVoice)
        }
        .buttonStyle(.bordered)
    }
}
