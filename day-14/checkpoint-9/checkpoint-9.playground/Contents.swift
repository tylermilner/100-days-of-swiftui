import UIKit

func randomInt(from integers: [Int]?) -> Int {
    return integers?.randomElement() ?? Int.random(in: 1...100)
}

let integers = [0, 49, 51, 23]
var randInt = randomInt(from: integers)
print(randInt)

randInt = randomInt(from: nil)
print(randInt)
