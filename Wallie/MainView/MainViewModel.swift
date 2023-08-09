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
        searchImages()
    }
    
    var categories: [String] = ["Abstract", "Flowers", "Clouds",
                                "Animals", "Drinks", "Food", "Sweet",
                                "Mountains", "Holidays", "Nature",
                                "People", "Sports", "Cars", "World"]
    
    var selectedCategory: String = "Abstract"
    
    var page = 1
    
    @Published var images: [ImageModel] = []
    
    func searchImages() {
        Task {
            let images = await repo.getImages(category: selectedCategory, page: page)
            DispatchQueue.main.async {
                self.images = images
            }
            page += 1
        }
    }
    
    @MainActor
    func loadImagesIfNeeded(index: Int) async {
        if index == images.count-5 {
            let newImages = await repo.getImages(category: selectedCategory, page: page)
            images += newImages
            page += 1
        }
    }
    
}

