//
//  ScrumdingerApp.swift
//  Scrumdinger
//
//  Created by Gabriel Chammas on 10/04/2022.
//

import SwiftUI

@main
struct ScrumdingerApp: App {
    @State private var scrums = DailyScrum.sampleData
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ScrumViews(scrums: $scrums)
            }
        }
    }
}
