import UIKit

struct Car {
    let model: String
    let numberOfSeats: Int
    private var currentGear: Int = 1
    
    init(model: String, numberOfSeats: Int) {
        self.model = model
        self.numberOfSeats = numberOfSeats
    }
    
    mutating func changeGear(to gear: Int) {
        guard gear >= 1 && gear <= 10 else {
            print("Invalid gear: \(gear)")
            return
        }
        currentGear = gear
        print("Changed to gear \(gear)")
    }
}

var myCar = Car(model: "3", numberOfSeats: 5)
myCar.changeGear(to: 10)
