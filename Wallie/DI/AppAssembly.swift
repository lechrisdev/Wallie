//
//  AppAssembly.swift
//  Wallie
//
//  Created by Le Chris on 02.08.2023.
//

import Foundation
import Swinject

class AppAssembly: Assembly {
    func assemble(container: Container) {
        
        
        // MARK: - Managers
        
        container.register(Router.self, factory: { _ in
            Router()
        })
        .inObjectScope(.container)
        
        container.register(Repository.self) { _ in
            Repository()
        }
        .inObjectScope(.container)
        
        // MARK: - ViewModels
        
        container.register(MainViewModel.self, factory: { container in
            MainViewModel(repo: container.resolve(Repository.self)!)
        })
        
        container.register(SearchScreenViewModel.self, factory: { container in
            SearchScreenViewModel(repo: container.resolve(Repository.self)!)
        })
    }
}
