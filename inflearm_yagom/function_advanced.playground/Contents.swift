import Swift

// MARK: - 매개변수 기본값

// 기본값을 갖는 매개변수는 매개변수 목록 중에 뒤쪽에 위치하는 것이 좋다.
/*
 func 함수이름(매개변수1이름: 매개변수1타입, 매개변수2이름: 매개변수2타입 = 매개변수기본값) -> 반환타입 {
    함수 구현부
    return 반환값
 }
 */

func greeting(friend: String, me: String = "tom") {
    print("Hello \(friend)! I'm \(me)")
}

// 매개변수 기본값을 가지는 매개변수는 생략할 수 있다.
greeting(friend: "hana") // Hello haha! I'm tom
greeting(friend: "john", me: "eric") // Hello john! I'm eric

// MARK: - 전달인자 레이블

// 전달인자 레이블은 함수를 호출할 때
// 매개변수의 역할을 좀 더 명확하게 하거나
// 함수 사용자의 입장에서 표현하고자 할 때 사용한다.
/*
 func 함수이름(전달인자 레이블 매개변수1이름: 매개변수1타입, 전달인자 레이블 매개변수2이름: 매개변수2타입) -> 반환타입 {
    함수 구현부
    return
 }
 */

// 함수 내부에서 전달인자를 사용할 때에는 매개변수 이름을 사용한다.
// 레이블을 사용하면 함수 이름이 같아도 다른 함수로 취급된다.
func greeting(to friend: String, from me: String) {
    print("Hello \(friend)! I'm \(me)")
}

// 함수를 호출할 때에는 전달인자 레이블을 사용해야 한다.
greeting(to: "hana", from: "tom") // Hello hana! I'm tom

//MARK: - 가변 매개변수

// 전달 받을 값의 갯수를 알기 어려울 때 사용할 수 있다.
// 가변 매개변수는 함수당 하나만 가질 수 있다.
// 매개변수의 맨 뒤에 위치하는게 좋다.
/*
 func 함수이름(매개변수1이름: 매개변수1타입, 전달인자 레이블 매개변수2이름: 매개변수2타입...) -> 반환타입 {
    함수 구현부
    return
 }
 */


func sayHelloToFriends(me: String, friends: String...) -> String {
    return "Hello \(friends)! I'm \(me)!"
}


print(sayHelloToFriends(me: "tom", friends: "hana", "eric", "wing"))
// Hello ["hana", "eric", "wing"]! I'm tom!

print(sayHelloToFriends(me: "tom"))
// Hello []! I'm tom!


/*
 위에 설명한 함수의 다양한 모양은 모두 섞어서 사용 가능하다.
 */

// MARK: - 데이터 타입으로서의 함수

// 스위프트는 함수형 프로그래밍 패러다임을 포함하는 다중 패러다임 언어이다.
// 스위프트의 함수는 일급객체이므로 변수, 상수 등에 저장이 가능하고
// 매개변수를 통해 전달할 수도 있다.

// MARK: 함수의 타입표현
// 반환타입을 생략할 수 없다.
// (매개변수1타입, 매개변수2타입 ...) -> 반환타입

var someFunction: (String, String) -> Void = greeting(to:from:)
someFunction("eric", "tom") // Hello eric! I'm tom

someFunction = greeting(to:from:)
someFunction("eric", "tom") // Hello eric! I'm tom

// 타입이 다른 함수는 할당할 수 없다.
// someFunction = sayHelloToFreinds(me:friends:)

func runAnother(function: (String, String) -> Void) {
    function("jenny", "mike")
}

// Hello jenny! I'm mike
runAnother(function: greeting(friend:me:))

// Hello jenny! I'm mike
runAnother(function: someFunction)
