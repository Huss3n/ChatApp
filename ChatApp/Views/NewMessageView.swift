//
//  NewMessageView.swift
//  ChatApp
//
//  Created by Muktar Hussein on 08/12/2022.
//

import SwiftUI
import SDWebImageSwiftUI


struct NewMessageView: View {
    @ObservedObject var getUsersVm = GetUsersModel()
    @ObservedObject var vm = ChatViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack{
            ScrollView{
                Text(getUsersVm.errorMessage)
                ForEach(getUsersVm.users) { user in
                    Button {
                        //
                    } label: {
                        HStack{
                            WebImage(url:URL(string: user.profileImageURL))
                                .resizable()
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color(.black), lineWidth: 1))
                            
                            Text(user.email)
                            Spacer()
                        }
                        .foregroundColor(.black)
                        .padding(.horizontal)
                    }

                    Divider()
                        .padding(.vertical, 8)
                }
            }
            .navigationTitle("New message")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Button("cancel") {
                        //
                       dismiss()
                    }
                }
            }
        }
    }
}

struct NewMessageView_Previews: PreviewProvider {
    static var previews: some View {
        NewMessageView()
    }
}
