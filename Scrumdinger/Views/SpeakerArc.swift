//
//  SpeakerArc.swift
//  Scrumdinger
//
//  Created by Gabriel Chammas on 30/04/2022.
//

import SwiftUI

struct SpeakerArc: Shape {
    let speakerIndex: Int // Index of cuurent speaker
    let numberOfSpeakers: Int // Total number of speakers in meeting
    
    private var degreesPerSpeaker: Double { //This divides the meeting timer circle on all the speakers equally
        360.0 / Double(numberOfSpeakers)
    }
    
    private var startAngle: Angle { //Determines angle from which to start drawing the speaker arc
        Angle(degrees: degreesPerSpeaker * Double(speakerIndex) + 1.0)
    }
    
    private var endAngle: Angle { //Determines angle at which to stop drawing the arc (subtract 1 to seperate arcs)
        Angle(degrees: startAngle.degrees + degreesPerSpeaker - 1.0)
    }
    
    func path(in rect: CGRect) -> Path {
        let diameter = min(rect.size.width, rect.size.height) - 24.0
        let radius = diameter / 2.0
        let center = CGPoint(x: rect.midX, y: rect.midY)
        
        return Path { path in
            path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        }
    }
}
