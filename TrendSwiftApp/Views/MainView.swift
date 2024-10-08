//
//  MainView.swift
//  TrendSwiftApp
//
//  Created by L Af on 2024/10/1.
//

import SwiftUI

struct MainView: View {
  init() {
      UITabBar.appearance().itemPositioning = .centered // 图标居中
      UITabBar.appearance().unselectedItemTintColor = UIColor.gray
      UITabBar.appearance().barTintColor = UIColor.white // 背景颜色
  }
  var body: some View {
          TabView {
              HomeView()
                  .tabItem {
                      Image(systemName: "house")
                  }
              
              SearchContentView()
                  .tabItem {
                      Image(systemName: "magnifyingglass")
                  }
              
              AddPostView()
                  .tabItem {
                      Image(systemName: "plus.square.fill")
                  }
              
              MessageMainList()
                  .tabItem {
                      Image(systemName: "message")
                  }
              
              ProfileView()
                  .tabItem {
                      Image(systemName: "person")
                  }
          }.accentColor(.black) // 修改选中标签颜色
      }
}

#Preview {
    MainView()
}
