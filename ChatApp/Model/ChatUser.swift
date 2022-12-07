//
//  ChatUser.swift
//  ChatApp
//
//  Created by Muktar Hussein on 08/12/2022.
//

import Foundation
struct ChatUser: Identifiable{
    var id: String{userId}
    
    let userId, email, profileImageURL: String
    
    init(data : [String: Any]) {
        self.userId = data["userId"] as? String ?? ""
        self.email = data["email"] as? String ?? ""
        self.profileImageURL = data["profileImageURL"] as? String ?? ""
    }
}
