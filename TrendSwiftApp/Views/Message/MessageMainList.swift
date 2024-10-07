//
//  MessageMainList.swift
//  TrendSwiftApp
//
//  Created by L Af on 2024/10/5.
//

import SwiftUI

struct ChatListView: View {
    @StateObject var viewModel = ChatViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.chats) { chat in
                    HStack {
                        Image(chat.avatar)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                            .padding(.trailing, 10)
                        
                        VStack(alignment: .leading) {
                            Text(chat.name)
                                .font(.headline)
                            Text(chat.message)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                    .listRowInsets(EdgeInsets()) // 移除每个列表项的内边距
                    .padding(.vertical, 5)
                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                        Button(role: .destructive) {
                            if let index = viewModel.chats.firstIndex(where: { $0.id == chat.id }) {
                                viewModel.chats.remove(at: index)
                            }
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }

                        Button {
                            viewModel.pinChat(chat)
                        } label: {
                            Label(chat.isPinned ? "Unpin" : "Pin", systemImage: chat.isPinned ? "pin.slash" : "pin")
                        }.tint(chat.isPinned ? .blue : .orange)
                    }
                }
                .onDelete(perform: viewModel.deleteChat)
            }
            .listStyle(PlainListStyle())  // 使用简洁的列表样式，去除默认背景
            .padding(.horizontal, 10)  // 移除 List 左右的 padding
            .navigationTitle("Messages")
        }
    }
}

struct MessageMainList: View {
  var body: some View {
      ChatListView()
  }
}

#Preview {
    MessageMainList()
}
