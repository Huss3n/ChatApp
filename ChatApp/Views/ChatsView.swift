//
//  ChatsView.swift
//  ChatApp
//
//  Created by Muktar Hussein on 08/12/2022.
//

import SwiftUI

struct ChatsView: View {
    @ObservedObject var vm = ChatViewModel()
    var body: some View {
        NavigationStack{
            ScrollView{
                ForEach(0..<10, id: \.self){message in
                    Text("Fake messages for now")
                }
            }
            .navigationTitle(vm.chatUser?.email ?? "")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Button {
                        //
                    } label: {
                        Text("< Back")
                    }

                }
            }
        }
    }
}

struct ChatsView_Previews: PreviewProvider {
    static var previews: some View {
        ChatsView()
    }
}
