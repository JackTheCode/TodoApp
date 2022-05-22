//
//  ServiceMock.swift
//  TodoAppTests
//
//  Created by phat nguyen on 5/22/22.
//

import Foundation

protocol ServiceMock: AnyObject {
    var bundle: Bundle { get }
    func loadJson<T: Decodable>(_ fileName: String, type: T.Type) -> T
}

extension ServiceMock {
    
    var bundle: Bundle {
        return Bundle(for: type(of: self))
    }
    
    func loadJson<T: Decodable>(_ fileName: String, type: T.Type) -> T {
        guard let filePath = bundle.url(forResource: fileName, withExtension: "json") else { fatalError("File path not found") }
        do {
            let data = try Data(contentsOf: filePath)
            let decodedJson = try JSONDecoder().decode(type, from: data)
            return decodedJson
        } catch {
            fatalError("Fail to decode json")
        }
    }
    
}
