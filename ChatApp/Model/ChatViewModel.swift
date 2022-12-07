//
//  ChatViewModel.swift
//  ChatApp
//
//  Created by Muktar Hussein on 08/12/2022.
//

import Foundation
// render the current logged in user and display their profile
class ChatViewModel: ObservableObject{
    @Published var errorMessage = ""
    @Published var chatUser: ChatUser?
    @Published var isUserCurrentlyLoggedOut = false
    
    init(){
        // present the login screen when the user is not logged in / == nil
        DispatchQueue.main.async {
            self.isUserCurrentlyLoggedOut = FirebaseManager.shared.auth.currentUser?.uid == nil
        }
        fetchCurrentUser()
    }
    
    
    func fetchCurrentUser(){
        guard let userId =  FirebaseManager.shared.auth.currentUser?.uid else {
            self.errorMessage = "Could not find user id"
            return
        }
        
        // fetch user
        FirebaseManager.shared.firestore.collection("UsersProfile").document(userId).getDocument { snapshot, error in
            if let error = error{
                print("Failed to fetch current user\(error)")
                return
            }
            guard let data = snapshot?.data() else {return}
            
            // extracting data from db
            self.chatUser = .init(data: data)
        }
    }
    
    // signout user
    func signOutUser(){
        isUserCurrentlyLoggedOut.toggle()
        try? FirebaseManager.shared.auth.signOut()
    }

}
