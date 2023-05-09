import Foundation

struct Subject: Equatable {
    var name: String
    var grade: String
}

enum InputError: Error, CustomDebugStringConvertible {
    case wrongInput
    case duplicated(name: String)
    
    var debugDescription: String {
        switch self {
        case .wrongInput: return "잘못된 입력입니다"
        case .duplicated(let name): return "\(name)은 이미 있습니다"
        }
    }
}

class MyCreditManager {
    
    private var isRunning = true
    private var answerMenu = ""
    private var students: [String : [Subject]] = [:]
    
    func run() {
        while isRunning {
            switch self.getMenu() {
            case "1" :
                do { try addStudent() } catch {
                    print(error)
                }
            case "2" : deleteStudent()
            case "3" : updateGrade()
            case "4" : deleteGrade()
            case "5" : checkGrade()
            case "X" : exitProgram()
            default : warnWrongMenu()
            }
        }
    }
    
    private func getMenu() -> String {
        print("원하는 기능을 입력하세요")
        print("1: 학생추가 , 2: 학생삭제 , 3: 성적추가(변경) , 4: 성적삭제 , 5: 평점보기 , X: 종료")
        return readLine() ?? "0"
    }
    
    private func addStudent() throws {
        print("추가할 학생의 이름을 입력해주세요.")
        
        guard let name = readLine(),
              name.contains(" ") == false else {
//            print("입력이 잘못되었습니다. 다시 확인해주세요.")
            throw InputError.wrongInput
        }
        
        if let _ = students[name] {
//            print("\(name)은 이미 존재하는 학생입니다. 추가하지 않습니다.")
            throw InputError.duplicated(name: name)
        }
        
        students[name] = []
        print("\(name) 학생을 추가했습니다.")
    }
    
    private func deleteStudent() {
        print("삭제할 학생의 이름을 입력해주세요.")
        let name = readLine() ?? " "
        if students[name] == nil {
            print("\(name) 학생을 찾지 못했습니다.")
        } else {
            students[name] = nil
            print("\(name) 학생을 삭제하였습니다.")
        }
    }
    
    private func updateGrade() {
        print("성적을 추가할 학생의 이름, 과목 이름, 성적(A+, A, F 등)을 띄어쓰기로 구분하여 차례로 작성해주세요.")
        print("입력예) Mickey Swift A+")
        print("만약에 학생의 성적 중 해당 과목이 존재하면 기존 점수가 갱신됩니다.")
        let inputs = (readLine() ?? " ").components(separatedBy: " ")
        guard inputs.count == 3 else {
            print("입력이 잘못되었습니다. 다시 확인해주세요.")
            return
        }
        let (name, subjectName, subjectGrade) = (inputs[0], inputs[1], inputs[2])
        if students[name] == nil {
            print("\(name) 학생을 찾지 못했습니다.")
        } else {
            students[name]?.append(Subject(name: subjectName, grade: subjectGrade))
            print("\(name) 학생의 \(subjectName) 과목이 \(subjectGrade)로 추가(변경)되었습니다.")
        }
    }
    
    private func deleteGrade() {
        print("성적을 삭제할 학생의 이름, 과목 이름을 띄어쓰기로 구분하여 차례로 작성해주세요.")
        print("입력예) Mickey Swift")
        let inputs = (readLine() ?? " ").components(separatedBy: " ")
        guard inputs.count == 2 else {
            print("입력이 잘못되었습니다. 다시 확인해주세요.")
            return
        }
        let (name, subjectName) = (inputs[0], inputs[1])
        if students[name] != nil {
            if let i = students[name]?.firstIndex(where: { $0.name == subjectName }) {
                students[name]?.remove(at: i)
                print(i)
                print("\(name) 학생의 \(subjectName) 과목의 성적이 삭제되었습니다.")
            }else {
                print("\(name) 학생의 \(subjectName) 과목의 성적은 찾지 못했습니다.")
            }
        } else {
            print("\(name) 학생을 찾지 못했습니다.")
        }
    }
    
    private func checkGrade() {
        print("평점을 알고싶은 학생의 이름을 입력해주세요.")
        let name = readLine() ?? " "
        if name.contains(" ") {
            print("입력이 잘못되었습니다. 다시 확인해주세요.")
        } else {
            if let student = students[name] {
                var sum = 0.0
                for subject in student {
                    print("\(subject.name): \(subject.grade)")
                    switch subject.grade {
                    case "A+": sum += 4.5
                    case "A" : sum += 4.0
                    case "B+": sum += 3.5
                    case "B" : sum += 3.0
                    case "C+": sum += 2.5
                    case "C" : sum += 2.0
                    case "D+": sum += 1.5
                    case "D" : sum += 1.0
                    default  : sum += 0.0
                    }
                }
                let str = String(format: "%.2f", sum / Double(student.count))
                print("평점 : \(str)")
            } else {
                print("\(name) 학생을 찾지 못했습니다.")
            }
        }
   }
    
    private func warnWrongMenu() {
        print("뭔가 입력이 잘못되었습니다. 1~5 사이의 숫자 혹은 X를 입력해주세요.")
    }
    
    private func exitProgram() {
        print("프로그램을 종료합니다...")
        isRunning.toggle()
    }
}

MyCreditManager().run()
