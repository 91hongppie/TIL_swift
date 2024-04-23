//
//  Service.swift
//  FireChat
//
//  Created by Kyuhong Jo on 4/23/24.
//

import Firebase
import FirebaseFirestore
import FirebaseAuth

struct Service {
    
    static func fetchUsers(completion: @escaping([User]) -> Void) {
        Firestore.firestore().collection("users").getDocuments { snapshot, error in
            guard var users = snapshot?.documents.map({ User(dictionary: $0.data()) }) else { return }
            
            if let i = users.firstIndex(where: { $0.uid == Auth.auth().currentUser?.uid}) {
                users.remove(at: i)
            }
            
            completion(users)
        }
    }
}
