import Foundation

// Set은 순서를 보장하지 않는다. 중복 요소를 제거한다.
let fruits: Set = ["Apple", "Pear", "Orange"]
let contacts = ["Adam": 123456789, "James": 987654321, "Amy": 912837465]
let word = "supercalifragilisticexpialidocious"
let halfOpenRange = 1..<5
let closedRange = 1...5


/*
 for in Loops
 */
for fruit in fruits {
    print(fruit)
}

for person in contacts {
    print(person.key)
    print(person.value)
}

for letter in word {
    print(letter)
}

for number in halfOpenRange {
    print("Loop is running")
    print(number)
}

for number in closedRange {
    print(number)
}

/*
 While Loops
 */

var now = Date().timeIntervalSince1970
let onSecondFromNow = now + 1

while 3 < 2 {
    now = Date().timeIntervalSince1970

    print("waiting...")
}
var a = 0
repeat {
    print(a)
    a += 1
} while a < 5

var b = 0
while b < 5 {
    print(b)
    b += 1
}

print(a, b)
