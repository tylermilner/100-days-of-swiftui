import UIKit

protocol Building {
    var numberOfRooms: Int { get }
    var cost: Int { get set }
    var estateAgent: String { get set }
    
    func printSalesSummary()
}

extension Building {
    
    func printSalesSummary() {
        func printSalesSummary() {
            print("\(numberOfRooms) rooms | $\(cost) | sold by \(estateAgent)")
        }
    }
}

struct House: Building {
    var numberOfRooms: Int = 5
    var cost: Int = 300_000
    var estateAgent: String = "John Doe"
}

struct Office: Building {
    var numberOfRooms: Int = 10
    var cost: Int = 1_000_000
    var estateAgent: String = "Jane Doe"
}
