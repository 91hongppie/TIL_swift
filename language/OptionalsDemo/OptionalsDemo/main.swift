
//let myOptional: String?
//
//myOptional = "Angela"
//
//let text: String = myOptional


/*
 Force Unwrapping = optional!
  - 가장 위험한 방법
 
 Check for nil value
 if optional != nil {
    optional!
 }
  - 코드가 길어진다.
  
 Optional Binding
 if let safeOptional = optional {
    safeOptional
 }
 
 Nil Coalescing Operator = optional ?? defaultValue
  -
*/

struct MyOptional {
    var property = 123
    func method() {
        print("I am the struct's method")
    }
}

let myOptional: MyOptional?

myOptional = MyOptional()

print(myOptional?.property)

/*
 Optional Chaining
    - optional?.property
    - optional?.method()
 */


