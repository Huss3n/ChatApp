//
//  ContentView.swift
//  ChatApp
//
//  Created by Muktar Hussein on 07/12/2022.
//

import SwiftUI


struct LoginView: View {
    let didUserCompleteProcess: () -> ()
    
    @State var isUserLoggedIn = false // yes
    @State var email = ""
    @State var password = ""
    @State var confirmPassword = ""
    @State var signUpMessage = ""
    @State var loginMessage = ""
    @State var showImagePicker = false
    @State var image : UIImage?
    
    
    var body: some View {
        NavigationStack{
            ScrollView{
                Picker("Login", selection: $isUserLoggedIn) {
                    Text("Login")
                        .tag(true)
                    Text("Sign up")
                        .tag(false)
                }
                .padding()
                .pickerStyle(.segmented)
                
                // profile picker
                if isUserLoggedIn == false{
                    Button {
                        // should show the image picker
                        showImagePicker.toggle()
                    } label: {
                        VStack{
                            if let image = self.image{
                                Image(uiImage: image)
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color.black, lineWidth: 1))
                                
                            }else{
                                Image(systemName: "person.fill")
                                    .padding()
                                    .font(.system(size: 100))
                                    .overlay(Circle().stroke(Color.black, lineWidth: 1))
                                
                            }
                        }
                    }
                }
                
                // user input fields
                VStack(spacing: 15){
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                    SecureField("Password", text: $password)
                    if isUserLoggedIn == false{
                        SecureField("Confirm password", text: $confirmPassword)
                    }
                }
                .padding()
                .textFieldStyle(.roundedBorder)
                
                
                // login / sign up button
                VStack{
                    Button {
                        // handle user login or sign up
                        handleUserAction()
                    } label: {
                        HStack{
                            Spacer()
                            Text(isUserLoggedIn ? "Login" : "Sign up")
                                .foregroundColor(.white)
                                .padding()
                                .font(.system(size: 20))
                                .fontWeight(.semibold)
                            Spacer()
                        }
                        .background(Color(.systemBlue).opacity(0.8))
                        .padding()
                    }
                }
                
                // display status message
                VStack{
                    Text(isUserLoggedIn ? loginMessage : signUpMessage)
                }
                .multilineTextAlignment(.center)
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundColor(.red)
                
                
            }
            .navigationTitle(isUserLoggedIn ? "Login" : "Create account")
            .fullScreenCover(isPresented: $showImagePicker, onDismiss: nil) {
                ImagePicker(image: $image)
            }
        }
    }
    
    func handleUserAction(){
        if isUserLoggedIn{
            // login user
            loginUser()
            self.loginMessage = "login sucessful"
        }else{
            // register user
            if password != confirmPassword{
                self.signUpMessage = "Passwords do not match"
                return
            }
            if image == nil{
                self.signUpMessage = "Pick a profile image"
                return
            }
            registerUser()
            self.signUpMessage = "Sign up succcessful"
        }
    }
    
    
    //  login user
    func loginUser(){
        FirebaseManager.shared.auth.signIn(withEmail: email, password: password) { result, err in
            if let err = err{
                self.loginMessage = "Failed to login user \(err)"
                return
            }
            self.loginMessage = "Login successful \(result?.user.uid ?? "")"
            // dismiss login view
            self.didUserCompleteProcess()
        }
    }
    
    // register user
    func registerUser(){
        FirebaseManager.shared.auth.createUser(withEmail: email, password: password) { result, error in
            if let error = error{
                self.signUpMessage = "Failed to create user \(error.localizedDescription)"
                return
            }
            self.signUpMessage = "User creation successful \(result?.user.uid ?? "")"
            self.addImageToStorage() // when it registers user it also sends the image to storage
        }
    }
    
    // function that adds image to storage
    func addImageToStorage(){
        // path is a file name we can ge from uuid
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {return}
        let ref = FirebaseManager.shared.storage.reference(withPath: uid)
        // the upload data
        guard let imageData = self.image?.jpegData(compressionQuality: 0.5) else {return}
        ref.putData(imageData, metadata: nil) { metadata, err in
            if let err = err{
                self.signUpMessage = "Failed to add image to storage  \(err)"
                return
            }
            //            self.imageMessage = "Image stored successfully"
            ref.downloadURL { url, error in
                if let error = error{
                    print(error)
                    self.signUpMessage = "Failed to get image download url \(error)"
                    return
                }
                self.signUpMessage = "Successfully stored image with url \(url?.absoluteString ?? "")"
                // call the store user to db function during storing image to storage
                guard let url = url else {return}
                self.storeUserInformation(profileImageURL: url)
            }
        }
        
    }
    
    // function that stores information
    func storeUserInformation(profileImageURL: URL){
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else{return}
        let userData = ["email" : self.email, "userId" : uid, "profileImageURL" : profileImageURL.absoluteString]
        FirebaseManager.shared.firestore.collection("UsersProfile").document(uid).setData(userData) { error in
            if let error = error{
                self.signUpMessage = "Failed to add image to db \(error)"
                return
            }
            self.signUpMessage = "Successfully added image url to db"
            self.didUserCompleteProcess()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(didUserCompleteProcess: {})
    }
}
