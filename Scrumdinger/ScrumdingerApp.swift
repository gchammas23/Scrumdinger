//
//  ScrumdingerApp.swift
//  Scrumdinger
//
//  Created by Gabriel Chammas on 10/04/2022.
//

import SwiftUI

@main
struct ScrumdingerApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ScrumViews(scrums: DailyScrum.sampleData)
            }
        }
    }
}
