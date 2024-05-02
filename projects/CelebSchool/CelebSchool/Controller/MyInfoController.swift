//
//  MyInfoController.swift
//  CelebSchool
//
//  Created by Kyuhong Jo on 5/1/24.
//

import UIKit
import FirebaseAuth
import GoogleSignIn

class MyInfoController: UITableViewController {
    // MARK: - Properties
    
    var user: User? {
        didSet { headerView.user = user }
    }
    
    private let headerView = MyInfoHeader(frame: .init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 200))
    
    private let googleLogInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("구글 연동", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(connectGoogle), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: - Selectors
    
    @objc func connectGoogle() {
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { signInResult, error in
            guard error == nil else { return }
            
            // If sign in succeeded, display the app's main content View.
            let email = signInResult?.user.profile?.email ?? ""
            let name = signInResult?.user.profile?.name ?? ""
            
            let user = signInResult?.user
            let idToken = user?.idToken?.tokenString
            let accessToken = user?.accessToken.tokenString
            let refreshToken = user?.refreshToken.tokenString
            
            print(email)
            print(name)
        }
    }
    
    // MARK: - API
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        
        headerView.delegate = self
        tableView.tableHeaderView = headerView
        
        tableView.contentInsetAdjustmentBehavior = .automatic
        
        googleLogInButton.frame.size = CGSize(width: 150, height: 48)
        googleLogInButton.center = view.center
        view.addSubview(googleLogInButton)
        
    }
    
}

extension MyInfoController: MyInfoHeaderDelegate {
    func handleLogin() {
        let controller = LoginController()
        controller.delegate = self
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
}


extension MyInfoController: LoginControllerDelegate {
    func completedSignIn() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Service.fetchUser(withUid: uid) { user in
            self.user = user
        }
        dismiss(animated: true)
    }
}
