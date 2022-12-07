//
//  ChatView.swift
//  ChatApp
//
//  Created by Muktar Hussein on 07/12/2022.
//

import SwiftUI
struct ChatView: View {
    @ObservedObject var vm = ChatViewModel()
    var body: some View {
        VStack{
            TopBarView()
            ScrollView{
                ForEach(0..<20, id: \.self){num in
                    MessagesView()
                }
            }
            .scrollIndicators(.hidden)
            .overlay(
                Button(action: {
                    //
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
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
