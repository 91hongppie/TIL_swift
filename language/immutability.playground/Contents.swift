
struct User {
    var name = "Tom"
    
    mutating func modifyName(_ newName: String) {
        self.name = newName
    }
}


var tom = User()
// let 상수에 할당된 struct는 내부 함수로 property 변경이 불가능하다.
tom.modifyName("Kyu")
print(tom.name)
