//
//  DataExtension.swift
//  Wallie
//
//  Created by Le Chris on 03.08.2023.
//

import Foundation

extension Data {
    
    func convertTo<SomeData: Decodable>(_ dataModel: SomeData.Type) -> SomeData? {
        do {
            let result = try JSONDecoder().decode(dataModel, from: self)
            return result
        } catch let error {
            print(error)
            return nil
        }
    }
}
