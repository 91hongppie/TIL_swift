/*
 Struct VS Class
    Struct는 상속 받을 수 없음
    Class는 상속 가능
 
    Struct는 내부 변수를 초기화 하지 않았을 때 선택적으로 Init 함수를 쓰지만 Class는 핈수로 작성해야한다.
 
    Struct는 값 타입, Class는 참조 타입
 
    Struct는 불변성이라 내부 요소 변경함수를 만들 때 앞에 mutating을 붙여줘야 한다.
    mutating함수가 발생하면 이전 struct는 파괴되고 업데이트된 값이 있는 새 struct가 생성된다.
 
    Structs are Passed by Value
    Classes are Passed by Reference
 
    default로 Struct를 이용하자.
    상속이 필요하거나 Objective-C 코드로 작업해야 한다면 클래스로 하자
 
    더 자세한 정보는
    https://docs.swift.org/swift-book/documentation/the-swift-programming-language/classesandstructures/
    여기로 가자
 */
