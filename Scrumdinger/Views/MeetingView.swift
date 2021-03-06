//
//  ContentView.swift
//  Scrumdinger
//
//  Created by Gabriel Chammas on 10/04/2022.
//

import SwiftUI
import AVFoundation

struct MeetingView: View {
    @Binding var scrum: DailyScrum
    @StateObject var scrumTimer = ScrumTimer()
    @StateObject var speechRecognizer = SpeechRecognizer()
    @State private var isRecording = false
    
    private var player: AVPlayer {
        AVPlayer.sharedDingPlayer
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16.0)
                .fill(scrum.theme.mainColor)
            VStack {
                MeetingHeaderView(secondsElapsed: scrumTimer.secondsElapsed, secondsRemaining: scrumTimer.secondsRemaining, theme: scrum.theme)
                
                MeetingTimerView(speakers: scrumTimer.speakers, theme: scrum.theme, isRecording: isRecording)
                
                MeetingFooterView(speakers: scrumTimer.speakers, skipAction: scrumTimer.skipSpeaker)
            }
        }
        .padding()
        .foregroundColor(scrum.theme.accentColor)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            scrumTimer.reset(lengthInMinutes: scrum.lengthInMinutes, attendees: scrum.attendees) // Reset the timer of the meeting
            
            scrumTimer.speakerChangedAction = {
                player.seek(to: .zero)
                player.play()
            }
            // Reset speech recognizer and start transcribing speech when view appears
            speechRecognizer.reset()
            speechRecognizer.transcribe()
            isRecording = true
            
            scrumTimer.startScrum() // Start the timer of the meeting
        }
        .onDisappear {
            scrumTimer.stopScrum() // Stop meeting timer
            
            speechRecognizer.stopTranscribing() // Stop transcribing speech
            isRecording = false
            
            // Create new history struct instance and add it to the history array
            let history = History(attendees: scrum.attendees, lengthInMinutes: scrum.timer.secondsElapsed / 60, transcript: speechRecognizer.transcript)
            scrum.history.insert(history, at: 0)
        }
    }
}

struct MeetingView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingView(scrum: .constant(DailyScrum.sampleData[0]))
    }
}
