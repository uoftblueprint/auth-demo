//
//  Profile.swift
//  auth-demo
//
//  Created by Olivia Li on 2020-10-01.
//

import Foundation

class Profile {
    var firstName: String!
    var lastName: String!
    var email: String!
    
    init(firstName: String, lastName: String, email: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
    }
}
