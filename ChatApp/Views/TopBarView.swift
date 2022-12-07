//
//  TopBarView.swift
//  ChatApp
//
//  Created by Muktar Hussein on 07/12/2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct TopBarView: View {
    @ObservedObject var vm = ChatViewModel()
    @State var showLogOut = false
    var body: some View {
        VStack {
            HStack{
                
                WebImage(url: URL(string: vm.chatUser?.profileImageURL ?? ""))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color(.black), lineWidth: 1))
                
                VStack(alignment: .leading, spacing: 8){
                    Text(vm.chatUser?.email.replacingOccurrences(of: "@gmail.com", with: "") ?? "")
                        .font(.title2).bold()
                    
                    HStack{
                        Circle()
                            .frame(width: 10, height: 10)
                            .foregroundColor(.green)
                        
                        Text("Online")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                Spacer()
                // logout button
                
                Button {
                    // present logout  option
                    showLogOut.toggle()
                } label: {
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                        .font(.system(size: 25))
                        .foregroundColor(.black)
                }
            }
            .padding()
            Divider()
        }
        .confirmationDialog("Logout", isPresented: $showLogOut, titleVisibility: .hidden) {
            Button("Logout", role: .destructive){
                // perfom logout function
                vm.signOutUser()
            }
        }
        .fullScreenCover(isPresented: $vm.isUserCurrentlyLoggedOut, onDismiss: nil) {
            //
            LoginView(didUserCompleteProcess: {
                self.vm.isUserCurrentlyLoggedOut = false
                self.vm.fetchCurrentUser()
            })
        }
    }
}

struct TopBarView_Previews: PreviewProvider {
    static var previews: some View {
        TopBarView()
    }
}
