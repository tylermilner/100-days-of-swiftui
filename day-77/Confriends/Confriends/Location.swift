//
//  Location.swift
//  Confriends
//
//  Created by Tyler Milner on 11/5/23.
//

import CoreLocation
import Foundation

struct Location: Codable, Identifiable, Equatable {
    var id: UUID = UUID()
    let latitude: Double
    let longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

extension Location {
    static let example = Location(latitude: 51.501, longitude: -0.141)
}
