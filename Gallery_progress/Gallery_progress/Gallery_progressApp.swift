//
//  Gallery_progressApp.swift
//  Gallery_progress
//
//  Created by rohit kumar on 30/07/23.
//

import SwiftUI

@main
struct Gallery_progressApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
