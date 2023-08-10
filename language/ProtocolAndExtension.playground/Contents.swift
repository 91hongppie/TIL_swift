import UIKit


protocol Walkable {
    var isBareFoot: Bool { get set }
    var speed: Double { get set }

    func walk(name: String)
}

extension Walkable {
    func walk(name: String) {
        if isBareFoot == true {
            print("\(name)은 맨발인 상태에 \(speed)속도로 걷습니다.")
        } else {
            print("\(name)은 신발인 상태에 \(speed)속도로 걷습니다.")
        }
    }
}

struct Person: Walkable {
    var isBareFoot: Bool
    var speed: Double
}

struct Animal: Walkable {
    var isBareFoot: Bool
    var speed: Double
}

let seungjin = Person(isBareFoot: false, speed: 5.0)
seungjin.walk(name: "승진")
let dog = Animal(isBareFoot: true, speed: 10.0)
dog.walk(name: "몽실")
