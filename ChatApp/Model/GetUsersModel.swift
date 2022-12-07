//
//  GetUsersFromFirestore.swift
//  ChatApp
//
//  Created by Muktar Hussein on 08/12/2022.
//

import Foundation

class GetUsersModel: ObservableObject{
    @Published var users = [ChatUser]()
    @Published var errorMessage = ""
    
    init() {
        fetchAllUsers()
    }
    
    // function that gets all users
    func fetchAllUsers(){
        // append users to users array
        FirebaseManager.shared.firestore.collection("UsersProfile").getDocuments { documentSnapshot, error in
            if let error = error{
                self.errorMessage = "Failed to fetch users\(error)"
                return
            }
            documentSnapshot?.documents.forEach({ snapshot in
                let data = snapshot.data() 
                self.users.append(.init(data: data))
            })
        }
    }
}
