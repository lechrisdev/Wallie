//
//  ContainerExtension.swift
//  Wallie
//
//  Created by Le Chris on 04.07.2023.
//

import Foundation
import Swinject

extension Container {
    static var shared: Container = {
        let container = Container()
        return container
    }()
}
