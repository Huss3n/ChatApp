//
//  MessagesView.swift
//  ChatApp
//
//  Created by Muktar Hussein on 07/12/2022.
//

import SwiftUI

struct MessagesView: View {
    var body: some View {
        VStack {
            HStack{
                Image(systemName: "person")
                    .padding()
                    .font(.system(size: 25))
                    .overlay(Circle().stroke(Color(.black), lineWidth: 1))
                
                // messages
                VStack(alignment: .leading, spacing: 4){
                    Text("Username")
                        .font(.body).bold()
                    Text("Message sent by the users")
                        .foregroundColor(.gray)
                        .font(.callout)
                }
                Spacer()
                // duration
                Text("10d")
                    .font(.callout)
                    .fontWeight(.semibold)
            }
            .padding()
            Divider()
        }
    }
}

struct MessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesView()
    }
}
