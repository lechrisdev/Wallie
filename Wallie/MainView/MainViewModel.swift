//
//  MainViewModel.swift
//  Wallie
//
//  Created by Le Chris on 02.08.2023.
//

import Foundation
import SwiftUI

class MainViewModel: ObservableObject {
    
    let repo: RepositoryProtocol
    
    init(repo: RepositoryProtocol) {
        self.repo = repo
    }
    
    var categories: [String] = ["Abstract", "Flowers", "Clouds",
                                "Animals", "Drinks", "Food", "Sweet",
                                "Mountains", "Holidays", "Nature",
                                "People", "Sports", "Cars", "World"]
    
    var selectedCategory: String = "Abstract"
    
    @Published var images: [ImageModel] = []
    
    @MainActor func searchImages() {
        Task {
            self.images = await repo.getImages(category: selectedCategory)
        }
    }
}

