
// struct를 만들 때 이름의 첫글자는 무조건 대문자로 한다.
// 그래야 데이터 타입이라는 것을 알수있다. Int, Float 처럼
struct Town {
    var name = "Angelaland"
    var citizens = ["Angela", "Jack Bauer"]
    var resources = ["Grain": 100, "Ore": 42, "Wool": 75]
    
    func fortify() {
        print("Defences increased!")
    }
}


// struct에 처음 데이터를 빼고 만들 수 있는데 그럼 반드시 init 메서드를 만들어야한다. js class의 constructor 같은 것
struct TownTwo {
    var name: String
    var citizens: [String]
    var resources: [String: Int]
    
    /**
        self는 js class의 this 와 같다.
     */
    init(name: String, citizens: [String], resources: [String: Int]) {
        self.name = name
        self.citizens = citizens
        self.resources = resources
    }
}


var myTown = Town()

print(myTown.name)

myTown.name = "Tomland"

print(myTown.name)
print("\(myTown.name) has \(myTown.resources["Grain"]!) bags of grain.")

myTown.citizens.append("Tom")
print(myTown.citizens)

myTown.fortify()

var anotherTown = TownTwo(name: "Tom", citizens: ["Dean", "Tim", "Mac"], resources: ["Grain": 100, "Coconut": 100])

print(anotherTown.name)
anotherTown.citizens.append("John")
print(anotherTown.citizens)


var ghostTown = TownTwo(name: "Ghosty mcGhostface", citizens: [], resources: ["Tumbleweed": 1])

ghostTown.citizens.append("Wilson")
print(ghostTown.name)
print(ghostTown.citizens)
