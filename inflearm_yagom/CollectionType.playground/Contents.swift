import UIKit

/* 컬렉션 타입 */
/* Array, Dictionary, Set */

import Swift

/*
    Array - 순서가 있는 리스트 컬렉션
    Dictionary - 키와 값의 쌍으로 이루어진 컬렉션
    Set - 순서가 없고, 멤버가 유일한 컬렉션
 */


// Mark: - Array

// 빈 Int Array 생성
var integers: Array<Int> = Array<Int>()
// 맨 뒤에 요소 추가
integers.append(1)
integers.append(100)
// 100.1은 Float 타입이라 오류 발생
// integers.append(100.1)
integers.count
integers.contains(100)
integers.contains(99)

integers.remove(at: 0)
integers.removeLast()
integers.removeAll()

integers.count

//integers[0]


// Array<Double>와 [Double]는 동일한 표현
// 빈 Double Array 생성
var doubles: Array<Double> = [Double]()

// 빈 String Array 생성
var strings: [String] = [String]()

// 빈 Character Array 생성
// []는 새로운 빈 Array
var characters: [Character] = []

// let을 사용하여 Array를 선언하면 불변 Array
let immutableArray = [1, 2, 3]

//immutableArray.append(4)
//immutableArray.removeAll()


// Mark: - Dictionary

// Key가 String 타입이고 Value가 Any인 빈 Dictionary 생성
var anyDictionary: Dictionary<String, Any> = [String: Any]()
anyDictionary["someKey"] = "value"
anyDictionary["anotherKey"] = 100

anyDictionary

anyDictionary["someKey"] = "dictionary"
anyDictionary

anyDictionary.removeValue(forKey: "anotherKey")

anyDictionary["someKey"] = nil
anyDictionary

let emptyDictionary: [String: String] = ["someKey": "value"]
let initializedDictionary: [String: String] = ["name": "yagom", "gender": "male"]

//emptyDictionary.removeValue(forKey: "key")
//emptyDictionary["key"] = "value"

// 에러 발생
// initializedDictionary["name"]의 값이 있을수고 있고 없을수도 있기 때문에 에러 발생
//let someValue: String = initializedDictionary["name"]


// Mark: - Set

// 빈 Int Set 생성
var integerSet: Set<Int> = Set<Int>()
integerSet.insert(1)
integerSet.insert(100)
integerSet.insert(99)
integerSet.insert(99)
integerSet.insert(99)

integerSet
integerSet.contains(1)
integerSet.contains(2)

integerSet.remove(100)
integerSet.removeFirst()

integerSet.count


let setA: Set<Int> = [1, 2, 3, 4, 5]
let setB: Set<Int> = [3, 4, 5, 6, 7]

// setA와 setB의 합집합
let union: Set<Int> = setA.union(setB)

// 정렬 - Array가 된다.
var sortedUnion: [Int] = union.sorted()
sortedUnion.append(9)
sortedUnion.append(0)


// setA와 setB의 교집합
let intersection: Set<Int> = setA.intersection(setB)

// setA - setB
let subtracting: Set<Int> = setA.subtracting(setB)







