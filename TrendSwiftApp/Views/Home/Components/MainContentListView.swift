//
//  MainContentListView.swift
//  TrendSwiftApp
//
//  Created by L Af on 2024/10/1.
//
import SwiftUI

struct MainContentListView: View {
    var images: [String] = ["background", "user_2", "ver_2"] // 替换为你的实际图片名称
  @State private var maxImageHeight: CGFloat = 600 // 用于存储最高的图片高度
  var body: some View {
//    ScrollView {
//            VStack(alignment: .leading, spacing: 0){
      ForEach(0..<5) { _ in
        VStack(alignment: .leading, spacing: 0) {
          HStack {
            Circle()
              .frame(width: 40, height: 40)
              .overlay(Circle().stroke(Color.gray, lineWidth: 1))
            Text("joshua_l")
              .fontWeight(.bold)
            Spacer()
            Image(systemName: "ellipsis")
          }.padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10) )
          
          
          // 图片区域 - 使用 TabView 来创建左右滑动的图片轮播效果
          TabView {
              ForEach(images, id: \.self) { image in
//                  GeometryReader { geometry in
                      Image(image)
                          .resizable()
                          .aspectRatio(contentMode: .fit) // 保持比例
                          .frame(
                            maxWidth: .infinity, // 宽度撑满
                              maxHeight: maxImageHeight // 控制最大高度为 600
                          )
                          .background(Color.black)
//                          .clipped() // 裁剪确保内容不超出
//                          .position(x: geometry.size.width / 2, y: geometry.size.height / 2) // 居中展示
//                  }
              }
          }
          .tabViewStyle(PageTabViewStyle()) // 添加分页样式的滑动效果
          .frame(minHeight: 200, maxHeight: 600) // 设置最小高度为 200，最大高度为 600
          .onAppear {
              // 更改分页指示器的颜色
              UIPageControl.appearance().currentPageIndicatorTintColor = UIColor.white
              UIPageControl.appearance().pageIndicatorTintColor = UIColor.lightGray
              UIPageControl.appearance().hidesForSinglePage = true
          }
          HStack(spacing: 15) {
            Image(systemName: "heart")
            Image(systemName: "message")
            Image(systemName: "paperplane")
            Spacer()
            Image(systemName: "bookmark")
          }
          .font(.title3)
          .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10) )
          
          Text("Liked by craig_love and 44,686 others")
            .fontWeight(.bold)
            .padding(.horizontal)
          
          Text("The game in Japan was amazing and I want to share some photos")
            .padding(.horizontal)
        }
        Spacer()
      }
      .listRowInsets(EdgeInsets())
      .padding(.horizontal, 0)
//            }.padding(0)
//    }.padding(0)
  }
}

#Preview {
    MainContentListView()
}
