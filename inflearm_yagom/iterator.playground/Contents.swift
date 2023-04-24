import Swift

/*
 반복문
 */

var integers = [1, 2, 3]
let people = ["yagom": 10, "eric": 15, "mike": 12]

// MARK: - for-in

/*
 for item in items {
    code
 }
*/

for integer in integers {
    print(integer)
}

// Dictionary의 item은 key와 value로 구성된 튜플 타입입니다.
for (name, age) in people {
    print("\(name): \(age)")
}

// MARK: - while

/*
 while condition {
    code
 }
 */


while integers.count > 1 {
    integers.removeLast()
}

// MAKR: - repeat-while

/*
 repeat {
    code
 } while condition
 */

repeat {
    integers.removeLast()
} while integers.count > 0

// 다른 언어의 do-while과 같다.
// repeat 구문이 먼저 진행된 후에 while의 condition을 체크한 이후에 반복 여부를 결정한다. 
