

/*
 조건이 5개 이상이면 switch문을 사용하고 미만이면 if 문을 사용하는게 더 빠르고 좋다.
 switch 문에서 범위로 지정하고 싶으면 from...to 로 범위를 지정하면 된다. ex) 3...5
 특정 숫자보다 작은 조건 = ...5
 최소 이상 최대 미만 = 최소값..<최대값 ex) 2..<5
 */

func loveCalculator() {
    let loveScore = Int.random(in: 0...100)
    
    switch loveScore {
    case ...40:
        print("You'll be forever alone")
    case ...80:
        print("you go together like Coke and Mentos")
    case ...100:
        print("You love each other like Kanye loves Kanye")
    default:
        print("Error lovescore is out of range")
    }
}

loveCalculator()
