//
//  Service.swift
//  CelebSchool
//
//  Created by Kyuhong Jo on 5/2/24.
//

import Firebase
import FirebaseFirestore
import FirebaseAuth

struct Service {
    
    static let shared = Service()
    
    func fetchUser(withUid uid: String, completion: @escaping(User) -> Void) {
        Firestore.firestore().collection("users").document(uid).getDocument { snapshot, error in
            if let error = error {
                print("DEBUG: Failed fetchUser")
                return
            }
            guard let dictionary = snapshot?.data() else { return }
            let user = User(dictionary: dictionary)
            completion(user)
        }
    }
    
    func updateUser(withUid uid: String, newData: [String: Any], completion: @escaping() -> Void) {
        Firestore.firestore().collection("users").document(uid).updateData(newData) { error in
            if let error = error {
                print("DEBUG: Failed to update user \(error.localizedDescription)")
            }
            completion()
        }
        
    }
    
    
}
