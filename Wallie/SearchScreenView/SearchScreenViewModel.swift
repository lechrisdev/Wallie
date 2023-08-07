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
    
    @MainActor func searchImages() {
        Task {
            self.images = await repo.getImages(category: text)
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
//        for timer in timers {
            timers?.invalidate()
//        }
//        timers.removeAll()
    }
}
