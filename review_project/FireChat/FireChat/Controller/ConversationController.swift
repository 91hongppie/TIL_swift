//
//  ConversationController.swift
//  FireChat
//
//  Created by Kyuhong Jo on 4/23/24.
//

import UIKit
import Firebase
import FirebaseAuth

private let reuseIdentifier = "ConversationCell"

class ConversationController: UIViewController {
    
    // MARK: - Properties
    
    private let tableView = UITableView()
    private var conversations = [Conversation]()
    private var conversationsDictionary = [String: Conversation]()
    
    private let addNewConversationButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.backgroundColor = .systemPurple
        button.tintColor = .white
        button.imageView?.translatesAutoresizingMaskIntoConstraints = false
        button.imageView?.heightAnchor.constraint(equalToConstant: 24).isActive = true
        button.imageView?.widthAnchor.constraint(equalToConstant: 24).isActive = true
        button.addTarget(self, action: #selector(showNewConversations), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchConversations()
        authenticateUser()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar(withTitle: "Messages", prefersLargeTitles: true)
    }
    
    // MARK: - Selectors
    
    func fetchConversations() {
        Service.fetchConversations { conversations in
            conversations.forEach({ conversation in
                self.conversationsDictionary[conversation.user.email] = conversation
                
            })
            self.conversations = Array(self.conversationsDictionary.values)
            self.tableView.reloadData()
        }
    }
    
    func showChatController(forUser user: User) {
        let controller = ChatController(user: user)
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func presentLoginScreen() {
            let controller = LoginController()
            controller.delegate = self
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true)
    }
    
    func authenticateUser() {
        if Auth.auth().currentUser?.uid == nil {
            presentLoginScreen()
        } else {
            print("DEBUG: User id is \(Auth.auth().currentUser?.uid)")
        }
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
            presentLoginScreen()
        } catch {
            print("Error signing out...")
        }
    }
    
    @objc func showNewConversations() {
        let controller = NewConversationController()
        controller.delegate = self
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
    
    @objc func showProfile() {
        // .insetGrouped = tableViewCell의 너비를 전체로 하지 않는다.
        let controller = ProfileController(style: .insetGrouped)
        controller.delegate = self
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        
        configureTableView()
        
        let image = UIImage(systemName: "person.circle.fill")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(showProfile))
        
        
        view.addSubview(addNewConversationButton)
        addNewConversationButton.translatesAutoresizingMaskIntoConstraints = false
        addNewConversationButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
        addNewConversationButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24).isActive = true
        addNewConversationButton.heightAnchor.constraint(equalToConstant: 56).isActive = true
        addNewConversationButton.widthAnchor.constraint(equalToConstant: 56).isActive = true
        addNewConversationButton.layer.cornerRadius = 56 / 2
    }
    
    func configureTableView() {
        tableView.backgroundColor = .white
        tableView.rowHeight = 80
        tableView.register(ConversationCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        tableView.frame = view.frame
    }
    
    
}


extension ConversationController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return conversations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ConversationCell
        cell.conversation = conversations[indexPath.row]
        return cell
    }
    
    
}

extension ConversationController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = conversations[indexPath.row].user
        let controller = ChatController(user: user)
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension ConversationController: NewConversationControllerDelegate {
    func controller(_ controller: NewConversationController, wantsToStartChatWith user: User) {
        dismiss(animated: true)
        showChatController(forUser: user)
    }
}

extension ConversationController: AuthenticationDelegate {
    func authenticationComplete() {
        dismiss(animated: true)
        configureUI()
        fetchConversations()
    }
}

extension ConversationController: ProfileControllerDelegate {
    func handleLogout() {
        logout()
    }
}
