//
//  ScrumViews.swift
//  Scrumdinger
//
//  Created by Gabriel Chammas on 15/04/2022.
//

import SwiftUI

struct ScrumViews: View {
    @Binding var scrums: [DailyScrum]
        
    var body: some View {
        List {
            ForEach($scrums) { $scrum in
                NavigationLink(destination: DetailView(scrum: $scrum)) {
                    CardView(scrum: scrum)
                }
                .listRowBackground(scrum.theme.mainColor)
            }
        }
        .navigationTitle("Daily Scrums")
        .toolbar {
            Button(action: {}) {
                Image(systemName: "plus")
            }
            .accessibilityLabel("New Scrum")
        }
    }
}

struct ScrumViews_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ScrumViews(scrums: .constant(DailyScrum.sampleData))
        }
    }
}
