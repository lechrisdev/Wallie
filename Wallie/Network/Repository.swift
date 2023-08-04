//
//  Repository.swift
//  Wallie
//
//  Created by Le Chris on 04.08.2023.
//

import Foundation
import Swinject

protocol RepositoryProtocol {
    func getImages(category: String) async -> [ImageModel]
}

class Repository: RepositoryProtocol {
    
    func getImages(category: String) async -> [ImageModel] {
        
        var images: [ImageModel] = []
                                            // ЗАГРУЗКА ГОРОДА ДЛЯ SEARCH SCREEN VIEW
        let data = await API.sendRequestData(request: Requests.getImages(category: category))
        if let result = data?.convertTo(ImageData.self) {
            images = result.domain
        }
        return images
    }
}

class RepositoryMock: RepositoryProtocol {
    
    func getImages(category: String) async -> [ImageModel] {
        [
            ImageModel(imageId: "0",
                       fullImageUrl: "https://images.unsplash.com/photo-1685815450272-806b5c531403?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1287&q=80",
                       smallImageUrl: "https://images.unsplash.com/photo-1685815450272-806b5c531403?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1287&q=80"),
            ImageModel(imageId: "1",
                       fullImageUrl: "https://images.unsplash.com/photo-1691040276996-0f70353a52e3?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1287&q=80",
                       smallImageUrl: "https://images.unsplash.com/photo-1691040276996-0f70353a52e3?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1287&q=80"),
            ImageModel(imageId: "2",
                       fullImageUrl: "https://images.unsplash.com/photo-1684144004516-305d67b7352d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=927&q=80",
                       smallImageUrl: "https://images.unsplash.com/photo-1684144004516-305d67b7352d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=927&q=80")
        ]
    }
}
