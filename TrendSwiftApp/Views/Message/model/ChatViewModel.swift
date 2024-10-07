//
//  ChatViewModel.swift
//  TrendSwiftApp
//
//  Created by L Af on 2024/10/7.
//

import SwiftUI

struct Chat: Identifiable {
    let id = UUID()
    var name: String
    var message: String
    var isPinned: Bool = false
    var avatar: String // 头像图片名称
}

class ChatViewModel: ObservableObject {
    @Published var chats: [Chat] = [
        Chat(name: "John Doe", message: "Hey, how are you?", avatar: "user_2"),
        Chat(name: "Alice", message: "See you later!", avatar: "user_2"),
        Chat(name: "Bob", message: "Meeting at 5PM", avatar: "user_2")
    ]
    
    func deleteChat(at offsets: IndexSet) {
        chats.remove(atOffsets: offsets)
    }
    
    func pinChat(_ chat: Chat) {
        if let index = chats.firstIndex(where: { $0.id == chat.id }) {
            chats[index].isPinned.toggle()
            // 将置顶的聊天放到列表顶部
            chats.sort { $0.isPinned && !$1.isPinned }
        }
    }
}
