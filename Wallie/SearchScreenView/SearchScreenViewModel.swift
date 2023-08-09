//
//  SearchScreenViewModel.swift
//  Wallie
//
//  Created by Le Chris on 02.08.2023.
//

import Foundation

class SearchScreenViewModel: ObservableObject {
    
    @Published var text: String = ""
    
    private var timers: Timer?
    
    let repo: RepositoryProtocol
    
    init(repo: RepositoryProtocol) {
        self.repo = repo
    }
    
    @Published var images: [ImageModel] = []
    
    var page = 1
    
    @MainActor func searchImages() {
        Task {
            self.images = await repo.getImages(category: text, page: page)
        }
    }
    
    @MainActor
    func loadImagesIfNeeded(index: Int) async {
        if index == images.count-5 {
            let newImages = await repo.getImages(category: text, page: page)
            images += newImages
            page += 1
        }
    }
    
    func startTimer(withTimeInterval timeInterval: TimeInterval, completion: @escaping () -> Void) {
        cancelAllTimers()
        let timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: false) { _ in
            completion()
        }
        timers = timer
    }
    
    private func cancelAllTimers() {
            timers?.invalidate()
    }
}
