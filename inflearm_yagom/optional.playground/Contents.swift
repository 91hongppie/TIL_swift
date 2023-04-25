import Swift


/*
 Optional Unwrapping
 */
func printName(_ name: String) {
    print(name)
}

var myName: String? = nil

// 전달되는 값의 타입이 다르기 때문에 컴파일 오류발생
//printName(myName)


/*
 if - let
 */
if let name: String = myName {
    print(name)
} else {
    print("myName == nil")
}

// name 상수는 if-let 구문 내에서만 사용 가능하다.
// 상수 사용범위를 벗어났기 때문에 컴파일 오류 발생
//printName(name)

var myName2: String? = "tom"
var yourName: String? = nil

// yourName이 nil이기 때문에 실행되지 않는다.
if let name = myName2, let friend = yourName {
    print("\(name) and \(friend)")
}

yourName = "hana"

// tom and hana
if let name = myName2, let friend = yourName {
    print("\(name) and \(friend)")
}

/*
 Force Unwrapping
 */

func printName2(_ name: String) {
    print(name)
}

var myName3: String? = "tom"

// tom
printName(myName3!)

myName3 = nil

// 강제추출시 값이 없으므로 런타임 오류 발생
//print(myName3!)

var yourName2: String! = nil

// nil 값이 전달되기 때문에 런타임 오류 발생
//printName2(yourName)

