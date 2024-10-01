//
//  MainStoriesView.swift
//  TrendSwiftApp
//
//  Created by L Af on 2024/10/1.
//

import SwiftUI

struct MainStoriesView: View {
    var body: some View {
      ScrollView(.horizontal, showsIndicators: false) {
          HStack(spacing: 20) {
              ForEach(0..<10) { _ in
                  VStack {
                      Circle()
                          .frame(width: 60, height: 60)
                          .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                      Text("Your Story")
                          .font(.caption)
                  }
              }
          }
          .padding(.horizontal)
      }
      .frame(height: 100) // 控制 Stories 部分的高度
      .listRowInsets(EdgeInsets()) // 去掉边距，使其看起来更自然
    }
}

#Preview {
    MainStoriesView()
}
