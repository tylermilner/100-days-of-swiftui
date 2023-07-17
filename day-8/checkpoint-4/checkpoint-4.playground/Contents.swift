import UIKit

enum NumError: Error {
    case outOfBounds
    case noRoot
}

func squareRoot(of num: Int) throws -> Int {
    switch num {
    case 1...10_000:
        for i in 1...num {
            if i * i == num {
                return i
            }
        }
        throw NumError.noRoot
    default:
        throw NumError.outOfBounds
    }
}

do {
    try squareRoot(of: 9)
    try squareRoot(of: 25)
    try squareRoot(of: 81)
//    try squareRoot(of: 50) // no root
    try squareRoot(of: 10_001) // out of bounds
} catch {
    print("Error: \(error)")
}
