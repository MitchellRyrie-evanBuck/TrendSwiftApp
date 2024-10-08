//
//  MessageList.swift
//  TrendSwiftApp
//
//  Created by L Af on 2024/10/3.
//

import SwiftUI

struct MessageList: View {
  var chat: Chat  // 传入 Chat 对象
  
    var body: some View {
      NavigationStack{
        MessageContent().navigationTitle("\(chat.name)")
      }
    }
}

//#Preview {
//    MessageList(
//      chat: Chat
//    )
//}
