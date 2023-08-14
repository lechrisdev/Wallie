//
//  Router.swift
//  Wallie
//
//  Created by Le Chris on 02.08.2023.
//

import SwiftUI
import UIKit
import Swinject

class Router {
    
    private var navigationController: UINavigationController?

    init() {
    }
    
    func configureNavigationController() {
        if navigationController == nil {
            let vm = Container.shared.resolve(MainViewModel.self)!
            let vc = UIHostingController(rootView: MainView(router: self,
                                                            viewModel: vm))
            navigationController = UINavigationController(rootViewController: vc)
            navigationController?.title = ""
            UIApplication.shared.windows.first?.rootViewController = navigationController
        }
    }
    
    func showSearchScreenView() {
        let vm = Container.shared.resolve(SearchScreenViewModel.self)!
        let vc = UIHostingController(rootView: SearchScreenView(router: self,
                                                                viewModel: vm))
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showResultScreenView(url: String) {
        let vc = UIHostingController(rootView: ResultScreenView(router: self,
                                                                url: url))
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.present(vc, animated: true)
    }
    
    func back(animated: Bool = true) {
        self.navigationController?.popViewController(animated: animated)
    }
    
    func dismiss(animated: Bool = true) {
        self.navigationController?.dismiss(animated: animated)
    }
    
}
