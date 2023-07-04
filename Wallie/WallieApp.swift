//
//  WallieApp.swift
//  Wallie
//
//  Created by Le Chris on 04.07.2023.
//

import SwiftUI

@main
struct WallieApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
