//
//  MemberListViewModel.swift
//  MemberList
//
//  Created by Allen H on 2022/10/16.
//

import UIKit


class MemberListViewModel {
    
    let dataManager: MemberListType
    
    let title: String
    
    // 멤버리스트 배열 데이터 ⭐️⭐️⭐️
    private var membersList: [Member] {
        return dataManager.getMembersList()
    }
    
    // 의존성 주입
    init(dataManager: MemberListType, title: String) {
        self.dataManager = dataManager
        self.title = title
    }
    
    
    // Output
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return self.membersList.count
    }
    
    // 뷰모델 생성
    func memberViewModelAtIndex(_ index: Int) -> MemberViewModel {
        let member = self.membersList[index]
        return MemberViewModel(dataManager: self.dataManager, with: member, index: index)
    }
    
    
    // Input
    func makeNewMember(_ member: Member) {
        dataManager.makeNewMember(member)
    }
    
    func updateMemberInfo(index: Int, with member: Member) {
        dataManager.updateMemberInfo(index: index, with: member)
    }
    
    
    // Logic
    func handleNextVC(_ index: Int? = nil, fromCurrentVC: UIViewController, animated: Bool) {
        // 기존의 멤버가 있을때
        if let index = index {
            let memberVM = memberViewModelAtIndex(index)
            goToNextVC(with: memberVM, fromCurrentVC: fromCurrentVC, animated: animated)
        // 새로운 멤버 생성시
        } else {
            let newVM = MemberViewModel(dataManager: self.dataManager, with: nil, index: nil)
            goToNextVC(with: newVM, fromCurrentVC: fromCurrentVC, animated: animated)
        }
    }
    
    private func goToNextVC(with memberVM: MemberViewModel, fromCurrentVC: UIViewController, animated: Bool) {
                
        let navVC = fromCurrentVC.navigationController
        
        let detailVC = DetailViewController(viewModel: memberVM)
        navVC?.pushViewController(detailVC, animated: animated)
    }
    
}


