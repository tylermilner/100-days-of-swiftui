import UIKit

class Animal {
    var legs: Int
    
    init(legs: Int) {
        self.legs = legs
    }
}

class Dog: Animal {
    
    init() {
        super.init(legs: 4)
    }
    
    func speak() {
        print("bark")
    }
}

class Corgi: Dog {
    
    override func speak() {
        print("woof woof")
    }
}

class Poodle: Dog {
    
    override func speak() {
        print("bark bark bark")
    }
}

class Cat: Animal {
    
    var isTame: Bool
    
    init(isTame: Bool) {
        self.isTame = isTame
        super.init(legs: 4)
    }
    
    func speak() {
        print("meow")
    }
}

class Persian: Cat {
    
    override func speak() {
        print("purrr")
    }
}

class Lion: Cat {
    
    override func speak() {
        print("roar")
    }
}
