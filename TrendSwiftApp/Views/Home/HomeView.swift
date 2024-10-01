//
//  HomeView.swift
//  TrendSwiftApp
//
//  Created by L Af on 2024/10/1.
//

import SwiftUI

struct HomeView: View {
  var body: some View {
          NavigationView {
              VStack(spacing: 0) {
                  // 自定义顶部导航栏
                  HStack {
                      Text("Instagram")
                          .font(.largeTitle)
                          .fontWeight(.bold)
                          .padding(.leading, 16)
                      
                      Spacer()
                      
                      HStack(spacing: 20) {
                          Image(systemName: "plus.app")
                          Image(systemName: "heart")
                          Image(systemName: "paperplane")
                      }
                      .font(.title2)
                      .padding(.trailing, 16)
                  }
                  .padding(.vertical, 10) // 控制导航栏的高度
                  .background(Color.white)
                  .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 2)
                  // ScrollView for content
                  List {
//                    ScrollView {
                      // Stories 部分
                      MainStoriesView()
                      
                      // Post 列表
                      MainContentListView()
//                    }.padding(0)
                  }
                  .listStyle(PlainListStyle()) // 使用普通列表样式
                  .padding(0)
              }
              .navigationBarHidden(true) // 隐藏系统默认的导航栏
          }
      }
}



#Preview {
    HomeView()
}
