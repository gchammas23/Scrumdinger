//
//  TrailingIconLabelStyle.swift
//  Scrumdinger
//
//  Created by Gabriel Chammas on 11/04/2022.
//

import SwiftUI

struct TrailingIconLabelStyle: LabelStyle {
    
    //This function gets called each time a Label uses this custom label style
    func makeBody(configuration: Configuration) -> some View {
        //The configuration parameter contains the text and icon of the Label
        // Now we can show them however we want
        HStack {
            configuration.title
            configuration.icon
        }
    }
}

extension LabelStyle where Self == TrailingIconLabelStyle {
    static var trailingIcon: Self { Self() }
}
