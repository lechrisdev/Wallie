//
//  API.swift
//  Wallie
//
//  Created by Le Chris on 02.08.2023.
//

import Foundation
import Alamofire

class API {
    
    // MARK: NEW
    static func sendRequestData(request: EndPoint) async -> Data? {
        do {
            return try await AF.request(request.path,
                                        method: request.httpMethod,
                                        parameters: request.parameters,
                                        encoding: URLEncoding.default)
            .validate(statusCode: 200..<300)
            .serializingData()
            .value
        } catch {
            print("Error sending request: \(error)")
            return nil
        }
    }
}

protocol EndPoint {
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var parameters: Parameters? { get }
}
    
enum Requests: EndPoint {
    case getImages(category: String, page: Int)
    
    var path: String {
        switch self {
        case .getImages:
            return "https://api.unsplash.com/search/photos"
        }
    }
    
    var httpMethod: Alamofire.HTTPMethod {
        switch self {
        case .getImages:
            return .get
        }
    }
    
    var parameters: Alamofire.Parameters? {
        switch self {
        case let .getImages(category, page):
            let parameters: [String: Encodable] = [
                "page": page,
                "per_page": 10,
//                "lang": "en" // ("ru", "uk")
                "query": category,
                "orientation": "portrait",
                "client_id": "dBZzBT11hAE4LJyiR7djNbU8FC_W6Bs-4u9OhQmA5dc" // My personal ID: delete, before upload?
            ]
            return parameters
        }
    }
    
    
}
