//
//  AppManager.swift
//  auth-demo
//
//  Created by Olivia Li on 2020-10-01.
//

import Foundation
import FirebaseFirestore
import Firebase

let db = Firestore.firestore()

class AppManager {
    static var current_user: Profile!
    
    static func getCurrentUser(uid: String) {
        db.collection("users").document(uid).getDocument { (snapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            }
            else {
                let firstName = snapshot!.get("firstName") as! String
                let lastName = snapshot!.get("lastName") as! String
                let email = snapshot!.get("email") as! String
                self.current_user = Profile(firstName: firstName, lastName: lastName, email: email)
            }
        }
    }
    
    static func addNewUser(uid: String, firstName: String, lastName: String, email: String) {
        let dataToSave: [String: Any] = ["firstName": firstName, "lastName": lastName, "email": email]
        db.collection("users").document(uid).setData(dataToSave) { err in
            if let err = err {
                print("Error saving new user info to Firestore: \(err)")
            } else {
                print("Collection/Document successfully written!")
            }
        }
    }
    
    
}
