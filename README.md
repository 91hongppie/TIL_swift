

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

# UITableView

## TableViewCell

- Selection 
  - None = 선택 안됨
  - Default = 선택

# Type Casting

## as?

```swift
if let messageCell = cell as? MessageCell {
  
} else {
  
}
```

- 옵셔널로 된다. 
- 위 코드에서 cell이 MessageCell 타입이 아닌 경우 else 문으로 빠진다.

## as!

``` swift
let messageCell = cell as! MesaageCell 
```

- 강제 다운캐스트

- 데이터 타입을 서브클래스로 변환, 캐스트한다.

- 문제점

  - 다른 타입에 잘못 변환했을때 코드 레벨에서 문제가 발생하지 않는다. - 런타임에서 발생한다.

  

## as

```swift
let newCell = messageCell as UITableViewCell
```

- as는 업캐스팅을 수행하는데 사용된다.



## Any, AnyObject, NSObject

- Any는 어떠한 타입
- AnyObject는 어떠한 클래스 타입, 구조체(struct) 안됨
  - swift에서 String, Int 등 원시타입은 struct이다.
- NSObject



# DispatchQueue

- 비동기 메서드



# ViewController Lifecycle

1. viewDidLoad()
   - 모든 IBOutlet, IBAction... 뷰와 관련된 모든 개체가 연결되어 액세스 가능해진다.
   - 뷰가 생성됐을 때 한 번만 호출된다.
2. viewWillAppear()
   - 뷰가 로드된 후에 운영체제가 viewWillAppear을 호출한다.
   - 화면에 뷰가 나타나기 직전에 호출된다.
   - 사용자는 아직 아무것도 볼 수 없다. 하지만 특정 UI 구성 요소를 숨기거나 보여주기에 좋은 시점이다.
   - 사용자는 뷰에서 어떤 변화도 감지할 수 없다.
3. viewDidAppear()
   - 이 단계에서 사용자가 화면을 볼 수 있다.
   - 카운트다운 타이머 시작하기 좋은 시점이다.
   - 화면에서 하든 애니메이션을 시작하든 사용자가 감지할 수 있는 어떤 것이든지
4. viewWillDisappear()
   - 뒤로 이동하거나 현재의 ViewController을 해제할 때 첫번째 메서드
   - 애니메이션을 멈추고 UI의 모습을 바꾸고 싶을 때
   - 네비게이션 바를 숨길 때 
5. viewDidDisappear()
   - 이 시점에 뷰는 이미 화면에 안보인다.
   - 이전 뷰를 바꿀 수 있는 마지막 함수
   - 말 그대로 사용자가 볼 수 없다는 뜻
   - ViewController가 파괴되지않고 내비게이션 스택의 백그라운드에 남아있는다.
   - 다음 화면으로 넘어가면 다음 화면의 viewWillApear, viewDidAppear 뒤에 호출된다.

# Application Lifecycle

1. App Launched
2. App Visible
3. App Recedes into Background
4. Resources Reclaimed
   - Application: didFinishLaunchingWithOptions
     - 앱이 실행되는 이벤트에 반응하고 이 코드가 다른 어떤 것보다 먼저 실행된다는 것을 보장
   - 앱 수명 주기 메서드를 어디서 확인할 수 있을까?
     - AppDelegate.swift, SceneDelegate.swift
       - ios 운영체제가 앱 수명 주기 측면에서 어떤 지점에 있는지 알려주는 것
       - ios 12 포함 그 이전에는 모든 수명 주기 메서드가 AppDelegate.swift에 있었다.
       - 하지만 ios13 부터 특히 ipadOS에선 앱이 다중 windows에서 실행될 수 있다.
       - 그 말은 앱의 다양한 인스턴스를 실행하는 여러 개의 창이 있을 수 있다. 즉, 두 개의  다른 장면이 있는 것이다.
       - 그래서 SceneDelegate가 각 window의 수명 주기에 대해 탐지한다.

> print(#function) = 호출되는 함수의 이름을 print 한다.



# Command Line

## Shell

- 운영체제 macos가 피스타치오라면 실제 견과류는 kernel, shell 은 껍데기
- kernel = 하드웨어와 인터페이스하는 실제 프로그램을 가리킨다. 운영체제의 핵심
- shell = 사람이 kernel과 상호 작용할 수 있도록 해주는 유저 인터페이스, 컴퓨터 하드웨어와도 같다.
- bash shell = CLI 또는 UNIX 시스템의 커맨드 라인 인터프리터, 유닉스에 기반한 시스템

> 왜 커맨드 라인을 사용할까?
> 더 큰 통제력을 위해서





# SwiftUI

- 애플의 새로운 UI 프레임워크
- 선언형 Swift 코드로 구축
- Drag and Drop to Create Code
- Easy Layouts VHZ Stack
  - VHZ = VerticalHorizontalZaxis
- Highly Reusable UI
  - 재사용하고 싶은 요소의 코드에 우클릭 -> Extract Subview 클릭 -> 코드상에 새로운 요소로 추출 되어 변경 가능
- Live Preview
- Cross Apple Platform
- - 

- ObservableObject
  - 한 개 혹은 그 이상의 속성을 어느 이해관계자에게든 방송할 수 있다는 뜻이다.
- - 

- Property Wrapper

  - @State
    - 변수를 업데이트 가능하게 하고 변수값이 바뀌면 ContentView를 새로고침한다.
  - @Published
    - 내용이 바뀔 때마다 알수 있다.
    - 콘텐츠뷰에서 이것을 듣기 위해서 해당 클래스 인스턴스를 생성한다. 이 때 변수앞에 @ObservedObject를 넣어야한다.
    - **핵심은 메인스레드에서 페치하도록 늘 확인해야 한다.**

  - ObservedObject
    - ObservableObject를 사용하려는 곳에서 달리는 태그





# Git and GitHub

- mkdir Story
  - Story 디렉토리 생성
- touch chapter1.txt
  - chapter1.txt 파일 생성
- open chapter1.txt
  - chapter1.txt 열기
- DS_Store
  - 설정 파일
  - 특정 프로젝트 폴더에 아이콘이 배열되는 방법 같은 것을 저장한다.
- git rm --cached -r .
  - git add 를 통해 스테이징 영역애 있는 모든 것을 제거한다.
- git branch ${name}
  - name에 들어간 이름의 브랜치를 만든다.
- git branch
  - 브랜치 목록을 보여준다.
- git checkout ${name}
  - name에 들어간 이름의 브랜치로 이동한다.
- git merge ${name}
  - name의 브랜치를 현재 브랜치에 머지한다.



# Xcode를 이용하여 커밋하기

1. 처음 프로젝트를 생성할 때 create Git repository on my Mac을 체크하여 생성하면 git init과 똑같은 역할을 한다.

2. 아래 이미지의 두번째를 클릭하면 변경사항을 볼 수 있다.

   ![Screenshot 2023-07-12 at 10.34.31 PM](/Users/tom.jo/Desktop/Screenshot 2023-07-12 at 10.34.31 PM.png)

3. 작업 표시줄의 Source Control의 commit을 클릭하면 내용을 입력하고 commit을 생성할 수 있다.
4. 작업을 망쳤을 때 이전 커밋으로 되돌리고 싶으면 Source Control의 Discard All Changes...를 통해 되돌릴 수 있다.

5. Xcode에 github 아이디로 로그인 할 수 있다.
6. Xcode에서 github에 repository를 만들 수 있다.
7. github 아이디로 로그인하고 Source Controll Navigator에 가서 프로젝트 이름을 우클릭하면 Create "project name" Remote on GitHub...을 클릭한다.
8. xcode를 통해 커밋을 push 하고 싶으면 작업표시줄의 Source Control에서 push 를 클릭한다.
9. pull도 xcode의 Source Control에 있다.
10. xcode로 관리하는게 터미널로 관리하는 것보다 편한지는 더 경험이 필요한듯 하다.





> Xcode에서 초기 컨트롤 뷰 화살표를 모르고 삭제했다면 다른 컨트롤 뷰를 선택해서 Is Initial View Controller을 체크한다.





# Sandboxing

- 하나의 앱이 다른앱에서 데이터를 가져오려고 하는 것을 막기 위해 ios에서 문제를 해결하는 방식
- 모든 앱이 각기 다른 모래 상자 안에 있다고 간주한다.
- 보호받는 환경일 뿐 아무것도 아니다.
- 각각의 앱은 앱과 관련된 파일과 문서를 저장하는 고유 폴더가 있다.
- 하나의 앱이 다른앱의 폴더에 접근할 수 없음



# Encodable

- Encodable을 상속 받으려면 클래스 안에 표준 데이터 타입만 있어야한다.
  - String, Boolean, Array, Dictionary
- 커스텀 데이터 타입이 있어선 안된다.



# UserDefaults VS NSCoder





# Databases

- UserDefaults
  - 작은 키 값 쌍 같은 아주 적은 양의 정보를 저장하고 싶을 때
- Codable
  - 적은 양의 사용자 지정 개체를 저장하고 싶을 때
- Keychain
  - 사용자 암호같은 안전한 데이터를 저장하고 싶을 때
- SQLite, Core Data, Realm
  - 많은 양의 데이터가 있는데 그 안에 있는 특정 항목을 끌어내기 위해 데이터를 쿼리해야 할 때
- SQLite
  - SQLite에 대해 이미 알거나 데이터베이스에 저장된 게 있다면 추천
- Core Data
  - 처음부터 데이터를 전송할 때 추천
  - 레퍼런스가 많다.
- Realm
  - 코어 데이터로 할 수 있는 대부분의 작업을 좀 더 빠르고 효율적으로 하고 싶을 때



# 진행하던 프로젝트에 Core Data 도입하기

- Core Data를 포함하여 새로 프로젝트를 만든다.
- 원래 진행하던 프로젝트에 Core Data 파일을 생성한다.
- 새로운 프로젝트의 AppDelegate에서 // MARK: - Core Data stack 부분을 복사 붙여넣기 한다.



# dynamic

```swift
    @objc dynamic var name: String = ""
```

- 동적 변수
- 앱이 실행되는 동안 이 속성의 변화를 모니터할 수 있다. 
- 빌드타임 에러 런타임 에러
- 

# Computed Properties

- 값이 계속 계산되는 속성을 만들 수 있게 해준다.

- 엑셀 스프레드 시트와 유사한 역할을 한다.

  ## getter

  ```swift
  let pizzaInches: Int = 10
  
  var numberOfSlices: Int {
    get {
  		return pizzaInches - 4 
    }
  }
  ```

  ## setter

  - set 내의 newValue는 고정

  ```swift
  let pizzaInches: Int = 10
  
  var numberOfSlices: Int {
      get {
          return pizzaInches - 4
      }
      set {
          print("numberOfSlices now has a new value which is \(newValue)")
      }
  }
  
  numberOfSlices = 12
  ```

  ## didSet, willSet

  ```swift
  var pizzaInInches: Int = 10 {
      willSet {
          print(pizzaInInches)
          print(newValue)
      }
      didSet {
          if pizzaInInches >= 18 {
              print("Invalid size specified, pizzaInInches set to 18.")
              pizzaInInches = 18
          }
      }
  }
  ```

  

# Swift Access Levels

1. private
   - 코드 블록의 중괄호 안에서만 사용이 가능하다.
2. fileprivate
   - 속성이나 메서드가 선언된 파일 내에서만 접근 가능
3. internal
   - 앱 모듈 어디에서든 속성이나 메서드가 접근이 가능하다.
   - var, let 변수
4. public
   - 다른 모듈에도 액세스가 허용된다.
5. open
   - 속성과 메서드 등 모든게 다른 모듈로 액세스될 수 있다.



보통 1~3만 쓴다

하지만 프레임워크, 라이브러리, SDK 개발을 작업하면 4, 5도 사용할 수 있다.

- 4, 5의 차이점
  - open은 다른 모듈에서 오버라이드와 서브클래싱이 가능하지만 public 접근자로 선언된 것은 다른 모듈에서는 오버라이드와 서브클래싱이 불가능하다



# Swift File VS Cocoa Touch File

- UIViewController, UITableViewController, UIView = Cocoa Touch File
- Custom Class = Swift File





# Structs VS Classes

- struct는 클래스처럼 생성할 수 있다.
- struct의 이름 짓는 방법도 클래스와 같다. 첫글자가 대문자
- struct는 메서드뿐 아니라 속성도 가질 수 있다.
- struct는 클래스가 할 수 있는 거의 모든 것을 할 수 있다.
- struct는 상속 불가하다.
- 메모리에서 클래스와 다른 장소에 저장된다.
- struct는 stack에 저장된다.
-  class는 heap에 저장되고 참조는 stack에 저장된다.
  - stack에 class가 저장된 heap의 위치를 저장한다.
- struct는 value type
- class는 reference type
- class의 속성이 var로 선언되어있으면 class를 초기화할 때 let으로 했어도 속성 변경이 가능하다. 하지만 let으로 초기화 된 변수에 class 자체를 다시 할당하거나 하는 변경은 불가능
- struct는 let 변수에 초기화 했으면 속성이나 메서드 변경 불가능하다.

| struct            | cleass                       |
| ----------------- | ---------------------------- |
| Simpler           | Has Inheritance              |
| Faster            | Works witdh Objective-C code |
| Deep copies       |                              |
| True Immutability |                              |
| No Memory Leaks   |                              |
| Threadsafe        |                              |

- Apple에서 공식적으로 새로운 사용자 지정 객체를 생성하고 싶을 때에는 기본적으로 struct를 사용해야 한다.
- 상속이 필요하거나 objective-c로 작업하고 싶을 때만 클래스로 바꾼다.
- Swift Access Level과 같다. 변수를 private로 생성하고 확장이 필요할 때만 바꾼다.



# Machine Learning

- 컴퓨터가 명확하게 프로그램되지 않고도 학습할 수 있도록 해주는 연구분야.
- 기계 학습에 가장 중요한 것은 학습은 두개의 넓은 카테고리로 나뉜다는 것이다.
- 지도 학습과 비지도 학습이다.

## 지도 학습

- 답을 알려주면서 학습시키는 것
- Discrete data - 이산형 데이터
- continuous data - 연속형 데이터
- 두 데이터의 차이는 간격이 있고 없고의 차이

## 비지도 학습

- 비구조적인 데이터에서 구조를 찾도록 학습
- 클러스터링
  - 컴퓨터가 데이터와 다양한 특징을 학습하고 데이터가 각각 다른 클러스터에 속하는지 파악하는 것

# Deep Learning



## 강화학습



# coreML

- 머신러닝을 iOS 프로젝트에 쉽게 통합할 수 있게 해준다.

1. 미리 훈련된 머신러닝 모델을 로드할 권한이 있고 개개인의 미리 훈련된 모델을 쉽게 전환할 방법을 포함한다. Caffe, Keras... 어디서든 그 모델을 xcode에서 사용될 클래스로 변환할 수 있다.
2. 모델을 로컬로 기기에 로드할 수 있도록 예측하는 것. 사용자가 앱을 다운로드해 앱이 이미진 인식, 음성 인식 등 훈련한 모델들이 예측할 수 있도록



- 앱을 이용해 모델을 훈련하는 동안 앱 데이터나 사용자가 생성한 데이터를 사용할 수 없다.

# Literal

- 컬러 리터럴 사용하는 방법

  ```swift
  #colorLiteral()
  ```

- 이미지 리터럴 사용하는 방법

  ```swift
  #imageLiteral()
  ```

  

# 어트리뷰트

## IBOutlet

- IB = Interface Builder
- 인터페이스 빌더에 대한 outlet이다.
- 코드상의 어떤 설정을 스토리보드로 전달하기 위한 키워드

## IBAction

- IB = Interface Builder
- 인터페이스 빌더에 대한 액션이 발생했을 때 실행하는 함수이다. 
- 스토리보드상에 이벤트가 일어날 경우 어떤 함수를 호출하여 실행시킬 것인지 알려주는 키워드





# 프레임워크 VS 라이브러리

- 프레임워크
  - 개발자가 이미 짜여진 룰을 따라 작업을 하는 것
- 라이브러리
  - 미리 만들어놓은 필요부분을 사용하는 것
- 공통점
  - 프로그램을 효율적으로(빨리) 만들기 위해, 다른 사람이 만들어 놓은 코드를 사용하는 것

# UIKit

# Foundation

- import Foundation이 왜 필요할까?

- Swift 언어

  - 언어의 기본적인 기능 제공
  - print() 함수
  - Int / String / Double 등 기본 타입(Basic Type)
  - 조건문(If) / 반복문(for/while)
  - 컬렉션 Array / Dictionary / Set
  - 이외에 기타 Swift 문법적인 기능 들
  - Data / Date 타입도 있으나(Foundation이 없으면 사용 못함)  (Foundation에 있는 NSData / NSDate를 감싸는 형태의 타입)

- Foundation

  - Objective-C 언어와 관련된 기능 제공
  - NSString 등 Objective-C 관련 타입들
  - NSObject클래스 (추상 클래스 관련)
  - Objective-C 관련, 컬렉션 NSArray / NSMutableArray / NSDictionary / NSSet 등

  - 앱을 만들때 반드시 필요한 기능들
  - NSData / NSDate 타입 (데이터와 날짜 관련)
  - 런루프(RunLoog)
  - Selector
  - 런루프(RunLoop) - Timer / 알림 등
  - 멀티쓰레드 - GCD(Grand Central Dispatch) / NSThread / Thread 등
  - 네트워크 - URL 등
  - JSON 등
  - 앱 지역화 관련
  - UIKit이 Foundation 을 감싸고 있다. - UIKit만 import 하면 Foundation에 있는 기능도 사용할 수 있다.



- 4 Layer
  1. Cocoa Touch Framework  = 앱 개발 기초 / 필수적인 기능 등
     - UIKit
       - 터치 / 모션 / 키패드 입력과 같은 사용자 상호작용 이벤트 처리
       - 카메라 / 디바이스 API
       - 뷰 / 윈도우 관리 / 시스템뷰와 뷰컨트롤러 제공
       - 프린트 / PDF 변환 API
       - UI애니메이션 등
     - AddressBookUI : 주소록 접근 관련
     - EventKitUI : 달력과 일정에 접근 관련
     - GameKit : 게임 센터 관련
     - MapKit : 앱에 추가하는 지도 관련
     - NotificationCenter : 노티피케이션 센터 관련
  2. Media Framework = 다양한 미디어 기능 구현 필요 기능 등
     - 사진과 동영상 관련
     - CoreGraphics : 2D 화면 그리기
     - AVFoundation : 오디오, 비디오의 재생 관련
  3. Core Services Framework = 시스템 서비스 제공 데이터 접근 등
     - Foundation
       - 문자열 / 날짜 처리
       - 런루프 / GCD / 쓰레드 / URL
     - Webkit : HTML 관련
     - CloudKit : iCloud 연동
     - CoreLocation : 위치 / 방향 정보
     - StoreKit : In-App Purchase 구현
  4. Core OS Framework = 보안 / 하드웨어 연동 등
     - CoreBluetooth : 블루투스 연결 / 비콘 등 관련
     - LocalAuthentication : TouchID / 사용자 인증
     - Security : 키체인 /인증서 관련

# enum

- enum 타입은 파일을 새로 만들어서 생성한다.

# AppDelegate.swift

- macOS의 command line  을 생성했을 때 있는 main.swift 파일을 대신한다.
- 앱이 실행될 때 가장 처음에 실행된다.

# Swift 공부하기 유용한 앱

- UIKitViewer
  - ios 앱을 만들면서 다루게 될 UIKIt 예시가 정리되어있는 앱
  - 앱을 켜서 여러 UI들을 세팅해 볼수있다.
- UIKit Lab
  - UIKitViewer와 비슷하다.
- SF Symbols
  - 애플에서 만들어놓은 Symbols를 모두 볼 수 있다.

# 공부해야할 것

1. 앱의 생명주기
2. ViewController의 생명주기
3. 뷰의 Drawing Cycle

# 문법

- weak 

  - 메모리 관리를 할 때 가리키는 상대방의 Reference Count를 올라가지 않게 한다.

- override

  - 재정의 했다는 뜻 
  - 상위 객체에 정의된 함수를 하위 객체에서 재정의

- 함수

  - 함수의 이름은 소문자로 시작하고 클래스나 구조체의 이름은 대문자로 시작한다.

- Guard let

  - ```swift
    guard let title = sender.currentTitle else { return }

  - sender.currentTitle이 nil일 경우 else에 들어가 return 되고 다음 코드는 실행되지 않는다.

  - ```swift
    guard let myNumString = numberLabel.text, let myNumber = Int(myNumString) else { return }
    ```

  - 위 코드처럼 두 조건을 한번에 검증할 수 있다.

- switch

  - enum 타입에 대한 switch 문에서는 모든 조건의 case가 있다면 default 문이 필요가 없다.
  - 일반 string 타입에 대한 switch 문에서는 default가 필요하다.

- for vs while

  - for 는 반복 횟수가 정해져 있을때 사용한다.

- if let

  - ```swift
    if  let input = userInput {
      if let number = Int(input) {
        ...
      }
    }
    ```

  - ```swift
    if let input = userInput, let number = Int(input) {
      ...
    }
    ```

  - 두 코드는 같다.

# 앱이 만들어지는 원리

- 웹과의 차이
  - 화면을 그리는 메커니즘의 완전히 다르다.
- iOS
  - 내부적으로는 아주 복잡한 메커니즘이 있지만, 실제로 잘 알지 못해도 쉽게 구현 가능하도록 설계되어 있다.
- 내부적인 메커니즘
  - 앱의 생명주기
    - 앱이 종료될 때 무엇을 한다든가 앱 사용하다가 전화가 온 경우라든가
  - 뷰컨트롤러의 생명주기
    - 어떤 화면에서 다음 화면으로 넘어가면 이전 화면은 어떻게 할 것인지 다음 화면으로 갔다가 다시 돌아오면 어떻게 동작할 것인지
  - Drawing Cycle
    - 1초에 60번 화면을 다시 그리는 일 
  - 등에 의해 완벽하게 통제된다.
- 화면의 터치

## 화면을 그리는 방식

|                           웹(Web)                            |                             iOS                              |
| :----------------------------------------------------------: | :----------------------------------------------------------: |
| **상단부터 아래로** (왼쪽 상단 디폴트) / <br />**네모 상자**(영역을 나누어)**로 그리기** | **오브젝트**(대부분 클래스) 들을 올려놓고 배치 / <br />내부 **속성 / 동작들**(메서드)이 이미 내장<br />(예) 버튼 누르면 동작 / 슬라이드 - 위치는 실수값을 이용 (0 ~ 1사이)<br />**배치 방법** - **프레임**(앱 화면 기준 왼쪽 상단) / **오토레이아웃** |
| 화면을 그리는 메커니즘(HTML/CSS)과<br />내부 동작(JavaScript 메커니즘이 완전 분리 | 하나의 클래스 내에 그리는 메커니즘과<br />동작에 대한 메커니즘이 공존<br />**클래스 / 객체지향 개념에서 출발할 수 밖에 없음** |
|      운영체제와 독립적 / 브라우저의 엔진에 의해 돌아감       |         앱을 만드는 것은 운영체제(iOS)와 밀접한 연관         |

​	

# Class

- class는 일반적으로 앞에 final을 붙여줘야한다.
  - class는 struct보다 느리다.
  - 동적 dispatch 때문에
  - 하지만 final을 붙이면 더 이상 상속을 하지 못하게 막는다.
  - 메서드가 다이렉트 디스패치가 일어나도록 한다.



# MARK

```swift
// MARK: - 킹정하는 부분
```

- 코드 스니펫으로 지정 가능하다



# 화면의 이해

|                            프레임                            |                         오토레이아웃                         |
| :----------------------------------------------------------: | :----------------------------------------------------------: |
|        상위뷰를 기준으로한 위치(position), 크기(size)        | 제약조건 (constraint)을 활용, <br />정렬(Alignment), 고정(Pinning) |
|             고정(화면 왼쪽 상단 or 상위뷰 기준)              |                   상대전(기준과 나) / 동적                   |
| 여러 크기의 화면 대응 불가<br />(가능하나 불편 - 화면 크기 불러와서 비율료 재계산) |                  여러 크기의 화면 대응 쉬움                  |
| 타입: CGRect = CGPoint + CGSize<br />(CG - 코어그래픽스 / 2차원기반 드로잉) |                      NSLayoutConstraint                      |
|                                                              | 결론적으로 오토레이아웃 결과<br />(화면크기 별로) 프레임으로 다 계산됨 |

- 스토리보드(Storyboard), 코드(programmatically) 둘 다 가능

# 디자인 패턴 / MVC 패턴

- 디자인 패턴
  - 공통의 문제에 검증된, 정형화된 해결책 - 개발패턴
  - 지속적이고 효율적인 유지보수, 지속적인 기능 개발과 효율성을 위한 템플릿
  - 건축으로 비유하면 건축 공법
  - 앱의 아키텍처
    - 예) Singleton 패턴, Delegate 패턴, MVC, MVVM, MVP...
- MVC (Model - View - Controller) 디자인 패턴
  - Model - 비즈니스 로직 (화면과 전혀 관련이 없는 로직과 데이터 관련)
  - View - UI 관련. 즉, 사용자 화면 표시(뷰컨트롤러의 명령을 받아 화면 표시)
  - Controller - 뷰컨트롤러, 모델의 정보를 어떻게 뷰에 표시할지를 해석해서 전달

# 앱의 생명주기

- 앱의 실행이 시작되서, 앱이 종료(메모리에서 내려감)되기까지의 주기가 존재
- (상태 변화의) 해당 시점에 호출되는 함수들이 있음
  - 앱이 실행중이다가, 다른 앱으로 전환되는 시점에 (특정) 함수가 호출됨

## 뷰컨트롤러의 생명주기

- 뷰컨트롤러의 생명 주기가 왜 필요할까?
  - 화면 전환에 있어 내부적인 메커니즘으로 반드시 호출되는 함수들이 있다.
  - 화면 전환에서 적절한 시점에 필요한 기능을 넣기 위해
  - 큰 그림으로 먼저 이해하기
- viewDidLoad()
  - 앱의 화면에 들어오면, 가장 먼저 실행시키는 함수)
- 내부적인 메커니즘
  - 운영체제에 의해서, 자동으로 호출되는 함수들이 있음
- 앱의 실행중 화면이 감춰졌다가 (다음 화면으로 넘어갔다가), 화면이 다시 보이기도 함
- (화면의 전환) 해당 시점에 호출되는 함수들이 있음
  - 다음 화면으로 갔다가 다시 돌아오면, (변경사항 업데이트를 위해) 서버에서 데이터를 다시 받아와야할 수도 있음

### 뷰컨트롤러의 생명주기 컨셉 이해하기

- loadView
  - 뷰를 메모리에 올리는 과정
  - 뷰를 바꿀 수 있는 시점 (코드로 뷰를 짠 경우)
  - 스토리보드로 뷰를 만들었을 때는 호출하면 안된다. ( 화면이 안나옴 )
- viewDidLoad
  - 스토리보드상의 뷰들과의 연결이 끝난 시점
  - 뷰가 생성되었을 때 한번만 호출
- viewWillAppear
  - 실제 스크린에 뷰가 나타나기 전에 호출
  - 뷰가 화면에 나타날때마다 계속 호출
- 추가 메커니즘 존재
  - updateViewConstraints
  - viewWillLayoutSubviews
  - viewDidLayoutSubviews
- viewDidAppear
  - 실제 스크린에 뷰가 나타난 후에 호출
  - (ex) 애니메이션 시작, 타이머 앱 - 초 시작 ...
- viewWillDiappear
  - 실제 스크린에 뷰가 사라지기 전에 호출
  - ( ex ) 애니메이션 멈춤, 타이머 앱 - 초 멈춤 ...
- viewDidDisappear
  - 실제 스크린에 뷰가 사라진 후에 호출
  - 메모리에서 없어진 것은 아님

- 전체적으로 시점이 중요 ( 모든 것을 한번에 이해하기는 어려움 / 실제로 부딪히면서 익힐 필요 )
