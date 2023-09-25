import UIKit



// 의존성 주입 ⭐️⭐️⭐️
// (개선된) 의존성: 프로토콜을 사용해서 의존성 분리 및 의존관계 역전시킴
// 주입: 쿨한C완성품가 의존성을 가지는 클래스(A, B)를 쿨한C완성품 밖에서 생성자를 통해 주입 (언제든지 교체 가능해져, 확장성이 늘어남)

// 의존성 분리 및 의존관계 역전 (Inversion Of Control)
// ====> 프로토콜(자격증) 사용의 장점 / 추상화의 장점

protocol 모듈화된부품 {
    var name: String { get set }
}



class A부품: 모듈화된부품 {
    var name: String = "A부품"
}

class B부품: 모듈화된부품 {
    var name: String = "B부품"
}



class 쿨한C완성품 {
    
    var a: 모듈화된부품
    
    init(a: 모듈화된부품) {    // 프로토콜 타입으로 선언
        self.a = a
    }
    
//    func change(a: 모듈화된부품) {   // 메서드로 부품을 바꾸는 구현도 가능
//        self.a = a
//    }
    
    func printName() {
        print(a.name)
    }
}



let moduledA = A부품()
let moduledB = B부품()


// (개선된) 의존성 주입을 통해 완성품을 만드는 방법
// 외부에서 언제든지 새로운 객체로 교체 가능, 확장 용이


let developedC = 쿨한C완성품(a: moduledA)
//let developedC3 = 쿨한C완성품(a: B부품())
developedC.printName()

//developedC.change(a: B부품())




let developedC2 = 쿨한C완성품(a: moduledB)
developedC2.printName()







//Copyright (c) 2023 we.love.code.allen@gmail.com
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in
//all copies or substantial portions of the Software.
//
//Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
//distribute, sublicense, create a derivative work, and/or sell copies of the
//Software in any work that is designed, intended, or marketed for pedagogical or
//instructional purposes related to programming, coding, application development,
//or information technology.  Permission for such use, copying, modification,
//merger, publication, distribution, sublicensing, creation of derivative works,
//or sale is expressly withheld.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//THE SOFTWARE.
