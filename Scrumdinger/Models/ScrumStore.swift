//
//  ScrumStore.swift
//  Scrumdinger
//
//  Created by Gabriel Chammas on 29/04/2022.
//

import Foundation
import SwiftUI

class ScrumStore: ObservableObject {
    @Published var scrums: [DailyScrum] = []
    
    /**
        Goes to user's document folder and returns the url of the file to save scrums to
     */
    private static func fileUrl() throws -> URL {
        try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) // Get base url for document folder
            .appendingPathComponent("scrums.data") // Append /scrums.data to the base URL and returns it
    }
    /**
        Loads the contents of the scrums file, returns either an array of scrums or an error
     */
    static func load(completion: @escaping (Result<[DailyScrum], Error>) -> Void) {
        // In this function, the completion is like a Promise that would either return a result (Array of scrums) or an error
        DispatchQueue.global(qos: .background) .async {
            // Run the following code in background thread
            do {
                let url = try fileUrl() // Try to get the file's url first
                
                guard let file = try? FileHandle(forReadingFrom: url) else {
                    // In case of error to access file data return an empty array as scrums
                    DispatchQueue.main.async {
                        completion(.success([]))
                    }
                    return
                } // Use FileHandle to read data of the file using it's url
                
                let dailyScrums = try JSONDecoder().decode([DailyScrum].self, from: file.availableData) // Decode available file data as array of scrums
                DispatchQueue.main.async {
                    completion(.success(dailyScrums)) // Return the array by passing it to the success of the completion closure (Like Promise.resolve)
                }
            } catch {
                // In case of error caught, return it in error of completion closure (Like Promise.reject)
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    /**
        Saves the passed array of scrums to the scrums.data file, returns number of saved scrums to file
     */
    static func save(scrums: [DailyScrum], completion: @escaping (Result<Int, Error>) -> Void) {
        DispatchQueue.global(qos: .background) .async {
            do {
                // Try to encode scrums passed to the function
                let encodedScrums = try JSONEncoder().encode(scrums)
                
                // Get file's url
                let outputFile = try fileUrl()
                
                // Try to write the encoded scrums to the file
                try encodedScrums.write(to: outputFile)
                
                // Return success with number of saved scrums
                DispatchQueue.main.async {
                    completion(.success(scrums.count))
                }
            } catch {
                // In case of error caught, return it in error of completion closure (Like Promise.reject)
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}
