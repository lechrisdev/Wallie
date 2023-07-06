//
//  WallieApp.swift
//  Wallie
//
//  Created by Le Chris on 04.07.2023.
//

import SwiftUI
import Swinject

@main
struct WallieApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
//            EmptyView()
//                .onAppear {
//                    _ = Assembler([AppAssembly()],
//                                  container: Container.shared)
//                    Container.shared.resolve(Router.self)!.configureNavigationController()
//                }
        }
    }
}
