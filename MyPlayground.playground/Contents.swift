import UIKit

//var greeting = "Hello, playground"
//print("Hello World")
/*
 우와
 주석 여러줄 쌉가능이다
 */

// print문 안에 코드를 넣는 것도 가능하다.
print("Hello \(2+3) World")

print("The result of 5 + 3 = \(5+3)")

var a = 5
var b = 8

var c = a
a = b
b = c

print("The value of a is \(a)")
print("The value of b is \(b)")


var numbers = [45, 73, 195, 53]

var computedNumbers = [numbers[0] * numbers[1], numbers[1] * numbers[2], numbers[2] * numbers[3]]

print(computedNumbers)


func greeting() {
    for _ in 0...3 {
        print("hello")
    }
}

greeting()
