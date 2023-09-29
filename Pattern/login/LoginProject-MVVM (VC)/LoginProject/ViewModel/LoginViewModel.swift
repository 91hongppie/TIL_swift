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
    
    // 유저가 입력한 글자 데이터
    private var emailString: String = ""
    private var passwordString: String = ""
    
    // 로그인 상태 데이터 ⭐️⭐️⭐️
    private var loginStatus: LoginStatus = .none {
        didSet {
            loginStatusChanged(loginStatus)
        }
    }
    
    var loginStatusChanged: (LoginStatus) -> Void = { _ in }
    
    
    // Input
    func setEmailText(_ email: String) {
        emailString = email
    }
    
    func setPasswordText(_ password: String) {
        passwordString = password
    }
    
    func loginButtonTapped() {
        guard !emailString.isEmpty && !passwordString.isEmpty else {
            self.loginStatus = .validationFailed
            return
        }

        APIService.shared.loginTest(username: emailString, password: passwordString) { [unowned self] result in
            switch result {
            case .success():
                self.loginStatus = .authenticated
            case .failure(_):
                self.loginStatus = .loginDenied
            }
        }
    }
    
    // Logic
    func getFirstPageViewModel() -> FirstPageViewModel {
        let firstPageVM = FirstPageViewModel(userEmail: self.emailString)
        return firstPageVM
    }
    
    
}
