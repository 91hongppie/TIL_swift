import UIKit

class A부품 {
    var name: String = "A부품"
}

class B부품 {
    var name: String = "B부품"
}


class C완성품 {
    
    // C완성품이 A부품에 의존한다 ⭐️⭐️⭐️ (의존성이 생긴다.)
    var a: A부품 = A부품()
    
//    init() {
//        self.a = A부품()
//    }
    
//    init(a: A부품) {
//        self.a = a
//    }
    
    func printName() {
        print(a.name)
    }
}


// 완성품을 만드는 방법 1

let c: C완성품 = C완성품()
c.printName()




// 완성품을 만드는 방법 2

let coolA: A부품 = A부품()
coolA.name = "멋진 A부품"


// 주입 방식만 개선
// 외부에서 주입하도록 만들었으나, 여전히 의존한다.

//let c2: C완성품 = C완성품(a: coolA)






// 주입(Injection)의 개념 ==============

class Person {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

// 외부에서 값을 주입(할당/초기화)해서 인스턴스 생성

let p1 = Person(name: "뉴진스")










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
