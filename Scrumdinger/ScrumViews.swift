//
//  ScrumViews.swift
//  Scrumdinger
//
//  Created by Gabriel Chammas on 15/04/2022.
//

import SwiftUI

struct ScrumViews: View {
    let scrums: [DailyScrum]
        
    var body: some View {
        List {
            ForEach(scrums) { scrum in
                CardView(scrum: scrum)
                    .listRowBackground(scrum.theme.mainColor)
            }
        }
    }
}

struct ScrumViews_Previews: PreviewProvider {
    static var previews: some View {
        ScrumViews(scrums: DailyScrum.sampleData)
    }
}
