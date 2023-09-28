//
//  MemberViewModel.swift
//  MemberList
//
//  Created by Allen H on 2022/10/16.
//

import UIKit


class MemberViewModel {
    
    // 원래의 배열 데이터에도 접근 필요
    let dataManager: MemberListType
    
    private var member: Member?
    private var index: Int?
    
    // (의존성 주입) 멤버, 인덱스를 가지고 뷰모델 생성
    init(dataManager: MemberListType, with member: Member? = nil, index: Int? = nil) {
        self.dataManager = dataManager
        self.member = member
        self.index = index
    }
    
    // Output
    var memberImage: UIImage? {
        member?.memberImage
        
        // 멤버 가지지 않고 구현한다면
        //guard let index = self.index else { return UIImage() }
        //return dataManager[index].memberImage
    }
    
    var memberIdString: String? {
        String(member?.memberId ?? Member.memberNumbers)
    }
    
    var nameString: String? {
        member?.name
    }
    
    var ageString: String? {
        member != nil ? String(member!.age!) : ""
    }
    
    var phoneNumString: String? {
        member?.phone
    }
    
    var addressString: String? {
        member?.address
    }
    
    var buttonTitle: String {
        member != nil ? "UPDATE" : "SAVE"
    }
    
    
    // Input
    func handleButtonTapped(image: UIImage?, name: String?, age: String?, phone: String?, address: String) {
        if member != nil {
            updateMember(image: image, name: name, age: age, phone: phone, address: address)
        } else {
            makeNewMember(image: image, name: name, age: age, phone: phone, address: address)
        }
    }
    
    
    // Logic
    // 기존의 멤버를 업데이트
    private func updateMember(image: UIImage?, name: String?, age: String?, phone: String?, address: String) {
        
        guard let member = self.member,
              let index = self.index else { return }

        let ageInt = Int(age ?? "") ?? 0
        
        // (뷰모델이 가지고 있는) 멤버 업데이트 ⭐️
        self.member = Member(exitingMember: member, image: image, name: name, age: ageInt, phone: phone, address: address)
        
        // 멤버 배열 업데이트 ⭐️
        self.dataManager.updateMemberInfo(index: index, with: self.member!)
    }
    
    // 새로운 멤버를 생성
    private func makeNewMember(image: UIImage?, name: String?, age: String?, phone: String?, address: String) {
        
        let ageInt = Int(age ?? "") ?? 0
        
        // 새로운 멤버를 생성해서 ⭐️
        let newMember = Member(image: image, name: name, age: ageInt, phone: phone, address: address)
        
        // 멤버 배열 업데이트 ⭐️
        self.dataManager.makeNewMember(newMember)
    }
    
    // 전화면으로 돌아가기
    func backToBeforeVC(fromCurrentVC: UIViewController, animated: Bool) {
        let navCon = fromCurrentVC.navigationController
        navCon?.popViewController(animated: animated)
    }
}
