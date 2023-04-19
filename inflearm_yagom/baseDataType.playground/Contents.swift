import UIKit

// Swift의 기본 데이터 타입
// Bool, Int, UInt, Float, Double, Character, String


// Bool
var someBool: Bool = true
someBool = false
//someBool = 0 // Bool 타입에는 Bool타입의 값만 줘야한다.
//someBool = 1

// Int
var someInt: Int = -100
//someInt = 100.1 // 정수에 실수 할당 불가능

// UInt (부호가 없는 정수, 양의 정수)
var someUInt: UInt = 100
// someUInt = -100
// someUInt = someInt


// Float (32비트 부동소수형 타입) - 정수타입을 넣어도 문제가 없다.
var someFloat: Float = 3.14
someFloat = 3


// Double (64비트 부동소수형 타입) - 정수타입을 넣어도 문제 없다. Float 타입을 넣으면 문제가 생긴다.
var someDouble: Double = 3.14
someDouble = 3
// someDouble = someFloat

// Character (한글자, 한문자, 유니코드로 사용할 수 있는 모든 문자를 넣어줄 수 있다.)
var someCharacter: Character = "🇰🇷"
someCharacter = "😄"
someCharacter = "가"
someCharacter = "A"
//someCharacter = "하하하"
print(someCharacter)



// String(문자열) - Character을 할당하면 문제가 생긴다.
var someString: String = "하하하 😄"
// someString = someCharacter
someString = someString + "웃으면 복이와요"
print(someString)

// 스위프트에서 다른 데이터타입과 자료교환은 암시적으로 불가능하다고 여기자
// 데이터 타입을 변환하는 방법은 나중에 알아보자
