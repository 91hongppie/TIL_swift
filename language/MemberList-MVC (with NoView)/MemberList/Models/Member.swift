//
//  Member.swift
//  MemberList
//
//  Created by Allen H on 2022/02/04.
//

import UIKit

// (커스텀) 델리게이트 패턴 구현
protocol MemberDelegate: AnyObject {
    func addNewMember(with member: Member)
    func updateMember(at index: Int, with member: Member)
}

// 멤버 모델
struct Member {
    lazy var memberImage: UIImage? = {
        guard let name = name else {
            return UIImage(systemName: "person")
        }
        return UIImage(named: "\(name).png") ?? UIImage(systemName: "person")
    }()
    
    static var memberNumbers: Int = 0
    
    let memberId: Int
    
    var name: String?
    var age: Int?
    var phone: String?
    var address: String?
    
    init(name: String?, age: Int?, phone: String?, address: String?) {
        
        self.memberId = Member.memberNumbers
        
        self.name = name
        self.age = age
        self.phone = phone
        self.address = address
        
        Member.memberNumbers += 1
    }
}
