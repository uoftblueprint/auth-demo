//
//  AppManager.swift
//  auth-demo
//
//  Created by Olivia Li on 2020-10-01.
//

import Foundation
import FirebaseFirestore

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
        db.collection("users").document(uid).setData(["firstName": firstName, "lastName": lastName, "email": email]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
    
}
