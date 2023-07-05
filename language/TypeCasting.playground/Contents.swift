import Foundation

class Animal {
    var name: String
    
    init(n: String) {
        name = n
    }
}

class Human: Animal {
    func code() {
        print("Typing away...")
    }
}


class Fish: Animal {
    func breatheUnderWater() {
        print("Breating under water.")
    }
}


let angela = Human(n: "Angela Yu")
let jack = Human(n: "Jack Bauer")
let nemo = Fish(n: "Nemo")
let num: NSNumber = 12
let word: NSString = "abc"

let neighbours: [NSObject] = [num, word]


//func findNemo(from animals: [Animal]) {
//    for animal in animals {
//        if animal is Fish {
//            print(animal.name)
//            let fish = animal as! Fish
//            fish.breatheUnderWater()
//            let animalFish = fish as Animal
//
//        }
//    }
//}
//
//findNemo(from: neighbours)
//
//let fish = neighbours[1] as! Fish
//
