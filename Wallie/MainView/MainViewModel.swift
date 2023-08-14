//
//  MainViewModel.swift
//  Wallie
//
//  Created by Le Chris on 02.08.2023.
//

import Foundation
import SwiftUI

class MainViewModel: ObservableObject {
    
    @Published var images: [ImageModel] = []
    @Published var errorMessage: String = ""
    @Published var showError: Bool = false
    
    var categories: [String] = ["Abstract", "Flowers", "Clouds",
                                "Animals", "Drinks", "Food", "Sweet",
                                "Mountains", "Holidays", "Nature",
                                "People", "Sports", "Cars", "World"]
    var selectedCategory: String = "Abstract"
    var page = 1
    
    let repo: RepositoryProtocol
    
    init(repo: RepositoryProtocol) {
        self.repo = repo
        searchImages()
    }
    
    func searchImages() {
        Task {
            do {
                let images = try await repo.getImages(category: selectedCategory, page: page)
                DispatchQueue.main.async {
                    self.images = images
                }
                page += 1
            } catch {
                DispatchQueue.main.async {
                    switch error.asAFError?.responseCode {
                    case 401:
                        self.errorMessage = "Cайт упал, очень жаль, мы работаем над ремонтом уже сейчас."
                    case nil:
                        self.errorMessage = "Нет интернета."
                    case .some(_):
                        self.errorMessage = error.localizedDescription
                    }
                    withAnimation(Animation.spring(response: 0.8, dampingFraction: 0.3, blendDuration: 0.6)) {
                        self.showError = true
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    withAnimation {
                        self.showError = false
                    }
                }
            }
        }
    }
    
    @MainActor
    func loadImagesIfNeeded(index: Int) async {
        do {
            if index == images.count-5 {
                let newImages = try await repo.getImages(category: selectedCategory, page: page)
                images += newImages
                page += 1
            }
        } catch {
            switch error.asAFError?.responseCode {
            case 401:
                errorMessage = "Cайт упал, очень жаль, мы работаем над ремонтом уже сейчас."
            case nil:
                errorMessage = "Нет интернета."
            case .some(_):
                errorMessage = error.localizedDescription
            }
            withAnimation(Animation.spring(response: 0.8, dampingFraction: 0.3, blendDuration: 0.6)) {
                self.showError = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                withAnimation {
                    self.showError = false
                }
            }
        }
    }
}
