import Foundation

let pizzaInches: Int = 10

var numberOfSlices: Int {
    get {
        return pizzaInches - 4
    }
    set {
        print("numberOfSlices now has a new value which is \(newValue)")
    }
}

numberOfSlices = 12
print(numberOfSlices)
