//
//  ChatView.swift
//  ChatApp
//
//  Created by Muktar Hussein on 07/12/2022.
//

import SwiftUI
struct ChatView: View {
    @ObservedObject var vm = ChatViewModel()
    @State var showNewMessageScreen = false
    @State var chatUser: ChatUser?
    
    var body: some View {
        VStack{
            NavigationStack{
                TopBarView()
                ScrollView{
                    ForEach(0..<20, id: \.self){num in
                        UsernameView()
                    }
                }
            }
            .scrollIndicators(.hidden)
            .overlay(
                Button(action: {
                    // present new message screen
                    showNewMessageScreen.toggle()
                }, label: {
                    Text("+ New message")
                        .font(.body).bold()
                        .frame(width: 300, height: 40)
                        .foregroundColor(.white)
                        .background(Color(.systemBlue))
                        .cornerRadius(30)
                        .shadow(color: .gray, radius: 10, x: 0, y: 0)
                }), alignment: .bottom
            )
            .fullScreenCover(isPresented: $showNewMessageScreen) {
                NewMessageView(didSelectNewUser: { user in
                    print(user.email)
                   self.chatUser = user
                })
            }
        }
        
    }
    struct ChatLogView: View{
        var body: some View{
            ScrollView{
                ForEach(0..<10) { num in
                    Text("Fake messages")
                }
            }.navigationTitle("Chat log view")
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
