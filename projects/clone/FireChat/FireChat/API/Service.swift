//
//  Service.swift
//  FireChat
//
//  Created by Kyuhong Jo on 4/17/24.
//

import Firebase
import FirebaseFirestore

struct Service {
    
    static func fetchUsers(completion: @escaping([User]) -> Void) {
        var users = [User]()
        Firestore.firestore().collection("users").getDocuments { snapshot, error in
            snapshot?.documents.forEach({ document in
                let dictionary = document.data()
                let user = User(dictionary: dictionary)
              
                users.append(user)
                completion(users)
            })
        }
    }
}
