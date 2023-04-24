import Swift

/* 함수 */

// MARK: - 함수의 선언

//MARK: 함수선언의 기본형태
/*
 func 함수이름(매개변수1이름: 매개변수1타입, 매개변수2이름: 매개변수2타입 ...) -> 반환타입 {
    함수 구현부
    return 반환값
 }
 */

func sum(a: Int, b: Int) -> Int {
    return a + b
}


//MARK: 반환 값이 없는 함수
/*
 func 함수이름(매개변수1이름: 매개변수1타입, 매개변수2이름: 매개변수2타입 ...) -> Void {
    함수 구현부
    return
 }
 */

func printMyName(name: String) -> Void {
    print(name)
}

