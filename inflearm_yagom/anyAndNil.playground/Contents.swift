import Swift

/*
 Any - Swift의 모든 타입을 지칭하는 키워드
 AnyObject - 모든 클래스 타입을 지칭하는 프로토콜
 nil - 없음을 의미하는 키워드
 */


// Mark: - Any
var someAny: Any = 100
someAny = "어떤 타입도 수용 가능합니다."
someAny = 123.12

// 에러발생 - Any 타입을 Double 타입에 할당할 수 없다.
// let someDouble: Double = someAny


// Mark: - AnyObject
class someClass {}

var someAnyObject: AnyObject = someClass()

// 에러발생 - 클래스인스턴스가 아닌 타입을 할당할 수 없다.
// someAnyObject = 123.12


// Mark: - nil
// nil은 다른 언어에서 null 이라고 생각하면 되겠다.

// 에러발생 - 모든 값을 넣어줄 수 있지만 빈 값은 들어올 수 없다.
// someAny = nil
// 에러발생
// someAnyObject = nil

