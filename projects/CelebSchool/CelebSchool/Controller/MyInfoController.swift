//
//  MyInfoController.swift
//  CelebSchool
//
//  Created by Kyuhong Jo on 5/1/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import GoogleSignIn

private let reuseIdentifier = "GoogleInfoCell"

class MyInfoController: UITableViewController {
    // MARK: - Properties
    
    var user: User? {
        didSet {
            headerView.user = user
            updateConfigureUI()
        }
        
    }
    
    private let sectionHeader = ["google"]
    
    private let headerView = MyInfoHeader(frame: .init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 200))
    
    private lazy var googleLogInButton: UIButton = {
        let button = UIButton(type: .system)
        
        
        button.setTitle(((self.user?.google) != nil) ? " 계정 추가하기" : " 구글 연동하기", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.contentMode = .scaleAspectFit
        let image = #imageLiteral(resourceName: "logo_google")
        button.setImage(image, for: .normal)
        button.backgroundColor = .white
        
        button.configuration?.imagePadding = 10
        
        button.addTarget(self, action: #selector(connectGoogle), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: - Selectors
    
    @objc func refreshAccessToken(index: Int) {
        guard let user = self.user else { return }
        GoogleService.shared.refreshAccessToken(user: user, index: index) { dictionary in
            guard let uid = Auth.auth().currentUser?.uid else { return }
            let newData = ["google": dictionary]
            Service.shared.updateUser(withUid: uid, newData: newData) { user in
                self.user = user
            }
        }
        
    }
    
    @objc func connectGoogle() {
        
        GIDSignIn.sharedInstance.signIn(withPresenting: self, hint: nil, additionalScopes: ["https://www.googleapis.com/auth/youtube.readonly"]) { signInResult, error in
            guard error == nil else { return }
            GoogleService.shared.connectGoogle(signInResult: signInResult) { dictionary in
                print(dictionary)
                guard let uid = Auth.auth().currentUser?.uid else { return }
                guard let email = dictionary["email"] as? String else { return }
                if (self.user?.google?.contains(where: { $0.email == email }) == true) {
                    return
                } else {
                    var newData = []
                    if let googleInfos = self.user?.google {
                        for googleInfo in googleInfos {
                            let dict = [
                                "email": googleInfo.email,
                                "subscriberNums": googleInfo.subscriberNums,
                                "channelName": googleInfo.channelName,
                                "thumbnailURLString": googleInfo.thumbnailURLString,
                                "channelId": googleInfo.channelId,
                                "refreshToken": googleInfo.refreshToken,
                                "accessToken": googleInfo.accessToken
                            ]
                            newData.append(dict)
                        }
                    }
                    
                    newData.append(dictionary)
                
                    
                    Service.shared.updateUser(withUid: uid, newData: ["google": newData]) { user in
                        self.user = user
                    }
                }
            }
        }
    }
    
    // MARK: - API
    
    // MARK: - Helpers
    
    func updateConfigureUI() {
        tableView.reloadData()
    }
    
    func configureUI() {
        
        headerView.delegate = self

        tableView.tableHeaderView = headerView
        tableView.delegate = self
        tableView.sectionHeaderTopPadding = 0
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        tableView.register(MyInfoGoogleCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.dataSource = self

        tableView.contentInsetAdjustmentBehavior = .automatic
        
        let stack = UIStackView(arrangedSubviews: [googleLogInButton])
        stack.axis = .vertical
        stack.spacing = 5
        
        view.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.topAnchor.constraint(equalTo: view.topAnchor, constant: 150).isActive = true
        stack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32).isActive = true
        stack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32).isActive = true
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
        Service.shared.fetchUser(withUid: uid) { user in
            self.user = user
        }
        dismiss(animated: true)
    }
}

extension MyInfoController {
    override func numberOfSections(in tableView: UITableView) -> Int { 
        return sectionHeader.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionHeader[section]
    }
}


extension MyInfoController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user?.google?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! MyInfoGoogleCell
        cell.googleInfo = user?.google?[indexPath.row]
        return cell
    }
}
