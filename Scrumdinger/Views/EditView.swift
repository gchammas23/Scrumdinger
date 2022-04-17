//
//  EditView.swift
//  Scrumdinger
//
//  Created by Gabriel Chammas on 16/04/2022.
//

import SwiftUI

struct EditView: View {
    @Binding var data: DailyScrum.Data
    @State private var newAttendeeName = ""
    
    var body: some View {
        Form {
            Section(header: Text("Meeting info")) {
                TextField("Title", text: $data.title)
                
                HStack {
                    Slider(value: $data.lengthInMinutes, in: 5...30, step: 1) {
                        Text("Meeting length")
                    }
                    .accessibilityLabel("\(Int(data.lengthInMinutes)) minutes")
                    Spacer()
                    Divider()
                    Text("\(Int(data.lengthInMinutes)) minutes")
                        .accessibilityHidden(true)
                }
                ThemePicker(selection: $data.theme)
            }
            
            Section(header: Text("Attendees")) {
                ForEach(data.attendees) { attendee in
                    Text(attendee.name)
                }
                .onDelete { indices in
                    data.attendees.remove(atOffsets: indices)
                }
                HStack {
                    TextField("New Attendee", text: $newAttendeeName)
                    Button(action: {
                        withAnimation {
                            //Create Attendee using name of attendee in text field
                            let attendee = DailyScrum.Attendee(name: newAttendeeName)
                            
                            //Add new attendee to attendee's list
                            data.attendees.append(attendee)
                            
                            //Clear the text field of attendee name
                            newAttendeeName = ""
                        }
                    }) {
                        Image(systemName: "person.badge.plus")
                            .accessibilityLabel("Add attendee")
                    }
                    // Disable add button if attendee name is empty
                    .disabled(newAttendeeName.isEmpty)
                }
            }
        }
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(data: .constant(DailyScrum.sampleData[0].data))
    }
}
