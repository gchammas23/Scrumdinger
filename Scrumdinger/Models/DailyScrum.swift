//
//  DailyScrum.swift
//  Scrumdinger
//
//  Created by Gabriel Chammas on 10/04/2022.
//

import Foundation

//Definition of a daily scrum meeting
struct DailyScrum {
    var title: String
    var attendees: [String]
    var lengthInMinutes: Int
    var theme: Theme
}

// Add sample data
extension DailyScrum {
    static let sampleData: [DailyScrum] =
    [
        DailyScrum(title: "Design", attendees: ["Cathy", "Daisy", "Simon", "William"], lengthInMinutes: 10, theme: .yellow),
        DailyScrum(title: "App Dev", attendees: ["Gaby", "Jennifer", "Luis", "Darla", "Euna"], lengthInMinutes: 5, theme: .orange),
        DailyScrum(title: "Web Dev", attendees: ["Theresia", "Rita", "Chris", "Sofia", "Lindsey", "Carla", "Diana", "Aga", "Chad", "Sarah"], lengthInMinutes: 15, theme: .poppy)
    ]
}
