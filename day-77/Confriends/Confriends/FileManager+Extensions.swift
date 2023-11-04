//
//  FileManager+Extensions.swift
//  BucketList
//
//  Created by Tyler Milner on 10/5/23.
//

import Foundation

extension FileManager {
    
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func decodeFileFromDocuments<T: Decodable>(_ file: String) -> T? {
        let filePath = Self.documentsDirectory.appendingPathComponent(file)
        
        guard let data = contents(atPath: filePath.absoluteString) else { return nil }
        
        do {
            let decoded = try JSONDecoder().decode(T.self, from: data)
            return decoded
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
