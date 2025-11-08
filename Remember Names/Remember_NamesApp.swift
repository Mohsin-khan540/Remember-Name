//
//  Remember_NamesApp.swift
//  Remember Names
//
//  Created by Mohsin khan on 05/11/2025.
//

import SwiftUI
import SwiftData

@main
struct Remember_NamesApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.light)
        }
        .modelContainer(for: Person.self)
    }
}
