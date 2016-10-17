//
//  User.swift
//  CARGo
//
//  Created by Vaishak iyer on 03/09/16.
//  Copyright © 2016 Vaishak iyer. All rights reserved.
//

import Foundation

class User
{
    
    var fname : String!
    var lname : String!
    var username : String!
    var email : String!
    var id : Int!
    
    init(fname: String, lname: String, username: String, email: String) {
        self.fname = fname
        self.lname = lname
        self.username = username
        self.email = email
    }
    func description() -> String {
        return "fname: \(fname)" +
            "lname: \(lname)" +
            "username: \(username)" +
            "email: \(email)"
    }

    
    
    
    
}
