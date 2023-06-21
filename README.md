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

