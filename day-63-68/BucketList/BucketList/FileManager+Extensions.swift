//
//  FileManager+Extensions.swift
//  BucketList
//
//  Created by Tyler Milner on 10/5/23.
//

import Foundation

extension FileManager {
    
    func getDocumentsDirectory() -> URL {
        let paths = urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func decodeFileFromDocuments<T: Decodable>(_ file: String) -> T? {
        let filePath = getDocumentsDirectory().appendingPathComponent(file)
        
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
