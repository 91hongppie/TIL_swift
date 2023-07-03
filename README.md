

# TIL_swift

swift 공부해보자

- struct를 외부에서 바꾸는 것과 내부에서 바꾸는 건 차이가 있다.
- 외부에서 변경할 때는 평소 변수 변경처럼 바꾸면된다.
- 내부에서 외부처럼 변경하려고 하면 self는 불변성이라는 에러 메시지가 발생한다.
- struct를 let 상수에 할당하면 내부적으로도 변경이 불가능하다.
- Cocoa Touch Class - Apple이 만든 UiKit을 포함한 프레임워크
- sugue 사용하는 방법
  - 부모 ControllerView에서 performSegue(withIdentifier: String, sender: self)를 통해 자식 ControllerView로 갈 수 있다.
  - withIdentifier에는 자식 ControllerView의 identifier가 들어가며 sender에는 self를 현재 ControllerView에서 호출하는 것을 알 수 있다.
  - 부모 ControllerView에서 prepare를 통해 performSegue를 호출한 뒤 자식 ControllerView로 가기 전에 필요한 작업을 할 수 있다.
    - 이 함수안에서 자식 ControllerView의 변수 값을 바꿔주거나 하는 작업을 할 수 있음

# Optionals

1. Force Unwrapping

   ``````swift
   optional!
   ``````

2. Check for nil value

   ``````swift
   if optional != nil {
   	optional!
   }
   ``````

3. Optional Binding

   ``````swift
   if let safeOptional = optional {
   	safeOptional
   }
   ``````

4. Nil Coalescing Operator

   ``````swift
   optional ?? defaultValue
   ``````

5. Optional Chaining

   ``````swift
   optional?.property
   optional?.method
   ``````

# UITextField

- UITextField에 문자열을 작성하고 키보드의 return 버튼으로 동작을 컨트롤하고 싶을 때는 UITextFieldDelegate가 필요하다 UIViewController에 UITextFieldDelegate를 같이 상속 받아 viewDidLoad에서 textField IBOutlet에 self를 할당하여 사용

- textFieldShouldReturn
  - textField에서 값을 입력하고 키보드의 return 버튼을 누르면 호출된다.
- textFieldShouldEndEditing
  - textField.endEditing(true)를 호출했을 때 호출된다.
- textFieldDidEndEditing
  - textField가 endEditing 됐을 때 호출된다.
  - textFieldShouldEndEditing 이 먼저 실행된 다음에 결과가 true일 때 호출



# Protocols

``````swift
protocol MyProtocol {
	// Define requirements
}
``````

``````swift
struct MyStruct: MyProtocol {}
class MyClass: MyProtocol {}
``````

- struct는 protocol만 상속 받을 수 있다.

- class는 class와 protocol을 같이 상속 받으면 class를 먼저 작성하고 뒤에 protocol을 작성한다.

  ``````swift
  class MyClass: Superclass, FirstProtocol, AnotherProtocol {
  	// class definition goes here
  }
  ``````

- protocol은 여러개 상속 받을 수 있다.

# Delegate Design Pattern

- swift에서 Protocol이 Delegate Pattern을 가능하게 해준다.
- 한글로 위임 패턴
- 위임은 합성을 상속만큼 강력하게 만든다.
- 위임에서는 두 객체가 하나의 요청을 처리한다.
- 수신 객체가 연산의 처리를 위임자(delegate)에게 보낸다.
- 이는 서브클래스가 부모클래스에게 요청을 전달하는 것과 유사한 방식이다.
- 위임과 동일한 효과를 얻으려면 수신 객체는 대리자에게 자신을 매개변수로 전달해서 위임된 연산이 수신자를 참조하게 한다.
- 이해는 되는데 아직은 어디서 사용될지 궁금하다..

# URLSession

- API 요청을 위한 swift 내장 클래스

## 사용법

1. Create a URL

   - URL 구조체를 이용하여 url을 생성한다.
   - ```let url = URL(string: urlString)```

2. Create a URLSession

   - URLSession을 생성한다.
   - ```let session = URLSession(configuration: .default)```

3. Give the session a task

   - session에 dataTask를 호출한다.

     ```swift
     let task = session.dataTask(with: url, completionHandler: handler(data:response:error:))
     
       func handle(data: Data?, response: URLResponse?, error: Error?) {
             if error != nil {
                 print(error!)
                 return
             }
             
             if let safeData = data {
                 let dataString = String(data: safeData, encoding: .utf8)
                 print(dataString)
             }
         }
     ```

4. Start the task

   - task를 시작한다.
   - ```task.resume()```
   - 메서드 이름이 resume인 이유는 - 새로 초기화된 작업은 일시 중단된 상태에서 시작되므로 이 메서드를 호출하여 작업을 시작해야 합니다. 라고 공식 문서에 나온다.
   - 즉, 처음 생성한 곳에서 일시 중단된 상태로 시작한다는 것

### etc

- 이번 강의에서는 session.dataTask 밖에 학습하지 못했다
- dataTask = 서버에서 메모리로 데이터를 검색하는 HTTP GET 요청에 사용하는 태스크
- uploadTask = HTTP POST, PUT 메서드를 통해 디스크에서 웹서버로 파일을 전송할 때 사용하는 태스크
- downloadTask = 임시의 파일 위치로 원격 서버에서 파일을 다운로드할 때 사용하는 태스크

# Closures

- 모든 함수를 클로저라고 한다.
- 이름이 있으면 named closure
- 이름이 없으면 unnamed closure
- 이름이 있는 클로저를 보통 함수라고 하고 이름이 없는 클로저를 클로저라고 한다.

## 작성법

- 함수

``````swift
func add(n1: Int, n2: Int) -> Int {
	return n1 + n2
}
``````

- 클로저

`````swift
{
  (n1: Int, n2: Int) -> Int in 
    return n1 + n2
}
`````

```swift
{
	(n1: Int, n2: Int) in n1 + n1 
}
```

```
{ $0 + $1 }
```

- 트레일링 클로저

  - 함수의 마지막 파라미터가 클로저일 때, 함수를 따로 만들어서 넣지않고 트레일링 클로저를 넣을 수 있다.

  ```swift
  func calculator(n1: Int, n2: Int, operation: (Int, Int) -> Int) -> Int {
    return operation(n1, n2)
  }
  
  let addResult  = calculator(n1: 2, n2: 3) { $0 + $1 }
  let multiplyResult = calculator(n1: 2, n2: 3) { $0 * $1 }
  
  print(addResult) // 5
  print(multiplyResult) // 6
  ```

  

# Parameter Names

- swift는 함수에서 외부 매개변수 이름과 내부 매개변수 이름을 따로 사용할 수 있다.
- 외부 매개변수 이름을 사용하지 않으려면 _ 로 대체한다.
- 외부 매개변수 이름을 사용하지 않을 때는 매개변수를 함수 호출할 때 순서대로 넣어주면된다.

```swift
func myFunc(name: Type) {
	print(name)
}
```

```swift
func myFunc(externalName internalName: Type) {
  print(internalName)
}

myFunc(externalName: value)
```

```
func myFunc(_ internalName: Type) {
  print(internalName)
}

myFunc(value)
```



# Extensions

```swift
extension SomeType {
	// Add new functionality
}
```

- JS의 prototype 과 비슷하다.
- 예를들어, Double 이라는 이름의 익스텐션을 만들면 Double 타입에서 따로 처리없이 호출할수있다.

```swift
var myDouble = 3.14159

extension Double {
    func round(to places: Int) -> Double {
        let precisionNumber = pow(10, Double(places))
        var n = self
        n = n * precisionNumber
        n.round()
        n = n / precisionNumber
        return n
    }
}


myDouble.round(to: 1)


let a = 234.234234

a.round(to: 2) // 234.23
```

# Third Party Libraries

- <a>cocoapods.org</a> 사이트에 접속하여 라이브러리를 검색할 수 있다.
- cocoapods 설치
  - ```sudo gem install cocopods```
    - cocoapod 설치
    - 처음 명령어 실행하면 좀 오랜 시간동안 아무것도 일어나지 않는데 인내심을 가지고 기다려보자...
  - ```pod setup --verbose```
    - github에 있는 cocoa pods의 마스터 브랜치에서 데이터를 받아오면서 cocoapods을 세팅

- .xcodeproj 와 .xcodeworkspace
  - 외부 라이브러리 사용 없이 프로젝트를 생성하고 사용할 때는 .xcodeproj를 실행해도 되지만, 외부 라이브러리를 사용했을 경우에는 xcodeworkspace로 프로젝트를 열어야 한다.
  - .xcodeproj는 프로젝트 설정파일들이 들어있는 디렉토리이고 .xcodeworkspace는 workspace와 프로젝트들에 대한 설명하는 파일이 들어있는 디렉토리
  - cocoapods 등을 사용하여 외부 라이브러리 등을 내 프로젝트에 추가한 경우에 xcodeworkspace에서 내 프로젝트와 외부 라이브러리를 연결해주는 역할을 하게된다.
  - 그래서 외부 라이브러리를 사용하는 경우에 .xcodeproj로 프로젝트를 실행하면 에러가 발생하게 된다.

- cocoapods vs Swift Package Manager
