//
//  SwiperWarp.swift
//  TrendSwiftApp
//
//  Created by L Af on 2025/1/9.
//

import SwiftUI

/// 动物图片视图组件
struct AnimalPhoto: View {
    /// 要显示的图片
    let image: String
    
    var body: some View {
      Image(image)
            .resizable()
            .aspectRatio(contentMode: .fill)
    }
}

/// 滑动卡片组件
struct SwiperWarp: View {
    var body: some View {
        // 创建水平滚动视图，隐藏滚动指示器
        ScrollView(.horizontal) {
            // 使用懒加载横向布局，设置图片间距
            LazyHStack(spacing: 22) {
                // 创建10个示例图片
              ForEach(swiperSampleItems, id: \.self ) { images in
                  ZStack {
                    AnimalPhoto(image: images.name ?? "background")
                          // 设置卡片尺寸
                          .frame( height: 550)
                          // 添加滚动过渡动画
                          .scrollTransition(axis: .horizontal) { content, phase in
                              return content
                                  // 根据滚动阶段设置水平偏移
                                  .offset(x: phase.value * -300)
                          }
                          // 设置容器相对框架
                          .containerRelativeFrame(.horizontal)
                          // 添加圆角裁剪
                          .clipShape(RoundedRectangle(cornerRadius: 32))
                          .shadow(color: .black.opacity(0.5
                             ), radius: 5, x: 0, y: 5)
                  }
                }
            }
            // 添加水平内边距
            .padding(.horizontal, 20)
            .scrollTargetLayout()
        }
        // 设置视图对齐的滚动行为
        .scrollTargetBehavior(.viewAligned)
    }
}

#Preview {
    SwiperWarp()
}
