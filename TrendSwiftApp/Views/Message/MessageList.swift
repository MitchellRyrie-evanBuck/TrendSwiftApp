//
//  MessageList.swift
//  TrendSwiftApp
//
//  Created by L Af on 2024/10/3.
//

import SwiftUI

struct MessageList: View {
    var body: some View {
      NavigationStack{
        MessageContent().navigationTitle("Message")
      }
    }
}

#Preview {
    MessageList()
}
