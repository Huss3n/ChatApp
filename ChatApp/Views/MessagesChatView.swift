//
//  ChatsView.swift
//  ChatApp
//
//  Created by Muktar Hussein on 08/12/2022.
//

import SwiftUI

struct MessagesChatView: View {
    @ObservedObject var vm = ChatViewModel()
//    let chatUser : ChatUser?
    
    var body: some View {
        NavigationStack{
            ScrollView{
                ForEach(0..<10, id: \.self){message in
                    Text("Fake messages for now")
                }
            }
            .navigationTitle("username: \(vm.chatUser?.email ?? "")")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
struct ChatsView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesChatView()
    }
}
