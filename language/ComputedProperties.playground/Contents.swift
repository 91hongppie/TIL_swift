import Foundation

let pizzaInches: Int = 16
var numberOfPeople: Int = 12
let slicesPerPerson: Int = 4

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

var numberOfPizza: Int {
    get {
        let numberOfPeopleFedPerPizza = numberOfSlices / slicesPerPerson
        return numberOfPeople / numberOfPeopleFedPerPizza
    }
    set {
        let totalSlices = numberOfSlices * newValue
        numberOfPeople = totalSlices / slicesPerPerson
    }
    
}

numberOfPizza = 4
print(numberOfPeople)
