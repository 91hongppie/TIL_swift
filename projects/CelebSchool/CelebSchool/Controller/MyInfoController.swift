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

class MyInfoController: UITableViewController {
    // MARK: - Properties
    
    var user: User? {
        didSet {
            headerView.user = user
            //            updateConfigureUI()
        }
        
    }
    
    private let headerView = MyInfoHeader(frame: .init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 200))
    
    private let googleLogInButton: UIButton = {
        let button = UIButton(type: .system)
        
        
        button.setTitle(" 구글 연동하기", for: .normal)
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
    
    @objc func refreshAccessToken() {
        guard let CLIENT_ID = Environment.clientId else { return }
        guard let API_KEY = Environment.youtubeAPIKey else { return }
        guard let REFRESH_TOKEN = self.user?.google.refreshToken else { return }
        
      
        // 여기서 뭐가 문젠지 찾아보려고 파라미터 하나씩 지워보다가 client_secret 지웠을 때 성공함..
        guard let url = URL(string: "https://oauth2.googleapis.com/token?grant_type=refresh_token&refresh_token=\(REFRESH_TOKEN)&client_id=\(CLIENT_ID)") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

        

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let _ = error {
                print("Failed refresh access token")
                return
            }
            guard let data = data else { return }
            
            guard let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else { return }
            guard let uid = Auth.auth().currentUser?.uid else { return }
            guard let newAccessToken = json["access_token"] else { return }
            var dictionary = ["google": [
                "email": self.user?.google.email,
                "subscriberNums": self.user?.google.subscriberNums,
                "channelName": self.user?.google.channelName,
                "thumbnailURLString": self.user?.google.thumbnailURLString,
                "channelId": self.user?.google.channelId,
                "refreshToken": self.user?.google.refreshToken,
                "accessToken": newAccessToken
            ]
            ]
            Service.shared.updateUser(withUid: uid, newData: dictionary) {
                Service.shared.fetchUser(withUid: uid) { user in
                    self.user = user
                }
            }
            
        }.resume()
    
    }
    
    @objc func connectGoogle() {
        
        GIDSignIn.sharedInstance.signIn(withPresenting: self, hint: nil, additionalScopes: ["https://www.googleapis.com/auth/youtube.readonly"]) { signInResult, error in
            guard error == nil else { return }
            
            // If sign in succeeded, display the app's main content View.
            let email = signInResult?.user.profile?.email ?? ""
            let name = signInResult?.user.profile?.name ?? ""
            let user = signInResult?.user
            let idToken = user?.idToken?.tokenString
            guard let refreshToken = user?.refreshToken.tokenString else { return }
            
            guard let uid = Auth.auth().currentUser?.uid else { return }
            
            guard let accessToken = user?.accessToken.tokenString else { return }
            
            let token = "Bearer \(accessToken)"
            guard let API_KEY = Environment.youtubeAPIKey else { return }
            guard let url = URL(string: "https://www.googleapis.com/youtube/v3/channels?part=snippet,statistics&mine=true&key=\(API_KEY)") else { return }
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            request.addValue(token, forHTTPHeaderField: "Authorization")
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let _ = error {
                    print("DEBUG: failed to get youtube")
                    return
                }
                
                guard let data = data else { return }
                
                guard let json = try? JSONDecoder().decode(ChannelListResponse.self, from: data) else { return }
                let subscriberNums = Int(json.items[0].statistics.subscriberCount) ?? 0
                let channelName = json.items[0].snippet.title
                let thumbnailURLString = json.items[0].snippet.thumbnails.default.url
                let channelId = json.items[0].id
                
                let dictionary = ["google": [
                    "email": email,
                    "subscriberNums": subscriberNums,
                    "channelName": channelName,
                    "thumbnailURLString": thumbnailURLString,
                    "channelId": channelId,
                    "refreshToken": refreshToken,
                    "accessToken": accessToken
                ]]
                
                Service.shared.updateUser(withUid: uid, newData: dictionary) {
                    Service.shared.fetchUser(withUid: uid) { user in
                        self.user = user
                    }
                }
            }.resume()
            
            
        }
    }
    
    // MARK: - API
    
    // MARK: - Helpers
    
    func updateConfigureUI() {
        guard let google = user?.google else { return }
        googleLogInButton.setTitle(" \(google)", for: .normal)
    }
    
    func configureUI() {
        
        
        view.backgroundColor = .white
        
        headerView.delegate = self
        tableView.tableHeaderView = headerView
        
        tableView.contentInsetAdjustmentBehavior = .automatic
        
        let stack = UIStackView(arrangedSubviews: [googleLogInButton])
        stack.axis = .vertical
        stack.spacing = 5
        
        view.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.topAnchor.constraint(equalTo: view.topAnchor, constant: 150).isActive = true
        stack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32).isActive = true
        stack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 32).isActive = true
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
