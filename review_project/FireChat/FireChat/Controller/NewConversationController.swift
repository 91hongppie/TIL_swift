//
//  NewConversationController.swift
//  FireChat
//
//  Created by Kyuhong Jo on 4/23/24.
//

import UIKit

private let reuseIdentifier = "UserCell"

protocol NewConversationControllerDelegate: class {
    func controller(_ controller: NewConversationController, wantsToStartChatWith user: User)
}

class NewConversationController: UITableViewController {
    // MARK: - Properties
    
    private var users = [User]()
    weak var delegate: NewConversationControllerDelegate?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchUsers()
        
    }
    
    // MARK: - Selectors
    
    @objc func handleDismissal() {
        dismiss(animated: true)
    }
    
    func configureUI() {
        configureNavigationBar(withTitle: "New Message", prefersLargeTitles: false)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleDismissal))
        
        tableView.tableFooterView = UIView()
        tableView.register(UserCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = 80
        
    }
    
    // MARK: - API

    func fetchUsers() {
        Service.fetchUsers { users in
            self.users = users
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Helpers
}

extension NewConversationController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! UserCell
        cell.user = users[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
}

extension NewConversationController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = users[indexPath.row]
        delegate?.controller(self, wantsToStartChatWith: user)
    }
}
