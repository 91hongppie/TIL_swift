import Swift

/* 조건문 */

let someInteger = 100

//MARK: - if-else

/*
 if condition {
    statements
 } else if condition {
    statements
 } else {
    statements
 }
 */

if someInteger < 100 {
    print("100 미만")
} else if someInteger > 100 {
    print("100 초과")
} else {
    print("100")
} // 100

// 스위프트의 조건에는 항상 Bool 타입이 들어와야한다.
// someInteger는 Bool 타입이 아닌 Int 타입이기 때문에
// 컴파일 오류가 발생한다.
// if someInteger { }

// MARK: - switch

/*
 switch value {
    case pattern:
        code
    default:
        code
 }
 */


// 범위 연산자를 활용하면 더욱 쉽고 유용하다.
switch someInteger {
case 0:
    print("zero")
case 1..<100:
    print("1~99")
case 100:
    print("100")
case 101...Int.max:
    print("over 100")
default:
    print("unknown")
} // 100

// 정수 외의 대부분의 기본 타입을 사용할 수 있다.
switch "tom" {
case "jake":
    print("jake")
case "mina":
    print("mina")
case "tom":
    print("tom!!")
default:
    print("unknown")
} // tom!!

/*
 switch 구문의 특징
 명확히 케이스가 다 명시되지 않는 한 default 구문을 꼭 작성해줘야 한다.
 default가 없으면 오류가 발생한다.
 case 다음에 break가 없지만 알아서 break가 걸린다.
 case "jake", "mina": 로 작성하거나
 case "jake":
    print("jake")
    fallthrough
 라고 fallthrough를 넣어주면 다음 case까지 진행된다.
 */
