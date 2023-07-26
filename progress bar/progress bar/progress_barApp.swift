//
//  progress_barApp.swift
//  progress bar
//
//  Created by rohit kumar on 26/07/23.
//

import SwiftUI

@main
struct progress_barApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
