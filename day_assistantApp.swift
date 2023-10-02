//
//  day_assistantApp.swift
//  day-assistant
//
//  Created by Kun Chen on 2023-09-28.
//

import SwiftUI
import Firebase

@main
struct day_assistantApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
