//
//  Member.swift
//  MemberList
//
//  Created by Allen H on 2022/02/04.
//

import UIKit

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
    
    // 새롭게 생성할때
    init(image: UIImage? = nil, name: String?, age: Int?, phone: String?, address: String?) {
        
        self.memberId = Member.memberNumbers
        
        self.name = name
        self.age = age
        self.phone = phone
        self.address = address
        
        Member.memberNumbers += 1
    }
    
    // 기존 멤버 업데이트 할때
    init(exitingMember: Member, image: UIImage? = nil, name: String?, age: Int?, phone: String?, address: String?) {
        
        self = exitingMember
        
        self.memberImage = image
        self.name = name
        self.age = age
        self.phone = phone
        self.address = address
    }
}
