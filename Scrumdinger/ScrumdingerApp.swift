//
//  ScrumdingerApp.swift
//  Scrumdinger
//
//  Created by Gabriel Chammas on 10/04/2022.
//

import SwiftUI

@main
struct ScrumdingerApp: App {
    @StateObject private var store = ScrumStore()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ScrumViews(scrums: $store.scrums) {
                    ScrumStore.save(scrums: store.scrums) { result in
                        if case .failure(let error) = result {
                            fatalError(error.localizedDescription)
                        }
                    }
                }
            }
            .onAppear {
                ScrumStore.load {result in
                    // Check what came back from the completion closure
                    switch(result) {
                    case .failure(let error):
                        // Throw an error in case of error
                        fatalError(error.localizedDescription)
                    case .success(let scrums):
                        // Set store.scrums to be the scrums returned from the success of load function
                        store.scrums = scrums
                    }
                }
            }
        }
    }
}
