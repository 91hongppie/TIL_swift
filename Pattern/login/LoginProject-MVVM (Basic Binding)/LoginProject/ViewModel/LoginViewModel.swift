//
//  LoginViewModel.swift
//  LoginProject
//
//  Created by Allen H on 2022/11/13.
//

import UIKit

enum LoginStatus {
    case none                // 로그인전
    case validationFailed    // 입력실패
    case loginDenied         // 로그인거절
    case authenticated       // 인증완료
}

class LoginViewModel {
    
    var emailString: 클래스로감싸진데이터<String> = 클래스로감싸진데이터("")
    var passwordString = 클래스로감싸진데이터("")
    
    // 로그인 상태 데이터 ⭐️⭐️⭐️
    var loginStatus: LoginStatus = LoginStatus.none
    
    
    // Output / Input 필요 없음 ⭐️⭐️⭐️
    
    
    // Logic
    func handleUserLogin(fromCurrentVC: UIViewController, animated: Bool) {
        guard !emailString.데이터값.isEmpty && !passwordString.데이터값.isEmpty else {
            self.loginStatus = .validationFailed
            return
        }
        
        APIService.shared.loginTest(username: emailString.데이터값, password: passwordString.데이터값) { [unowned self] result in
            switch result {
                case .success():
                    // 로그인 데이터 상태 변경
                    self.loginStatus = .authenticated
                    self.goToNextVC(fromCurrentVC: fromCurrentVC, animated: true)
                    
                case .failure(_):
                    // 로그인 데이터 상태 변경
                    self.loginStatus = .loginDenied
                    print("로그인실패")
            }
        }
    }
    		
    private func goToNextVC(fromCurrentVC: UIViewController, animated: Bool) {
        print(self.emailString.데이터값)
        let firstVM = FirstPageViewModel(userEmail: self.emailString.데이터값)
        let nextVC = FirstPageViewController(viewModel: firstVM)
        nextVC.modalPresentationStyle = .fullScreen
        
        fromCurrentVC.present(nextVC, animated: true)
    }
    
    
}
