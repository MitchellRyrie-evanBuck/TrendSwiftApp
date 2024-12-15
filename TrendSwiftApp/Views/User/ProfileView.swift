//
//  ProfileView.swift
//  TrendSwiftApp
//
//  Created by L Af on 2024/10/1.
//
 
 import SwiftUI
 
 struct ProfileView: View {
     @State public var scrollOffset: CGFloat = 0
     
     var body: some View {
         ZStack(alignment: .top) {
             ScrollView {
                 VStack(spacing: 0) {
                     imageUserView(scrollOffset: $scrollOffset)
                     GridUserView()
                 }
                 .background(GeometryReader { geo in
                     Color.clear.preference(key: ScrollOffsetPreferenceKey.self, value: geo.frame(in: .named("scroll")).origin.y)
                 })
             }
             .coordinateSpace(name: "scroll")
             .ignoresSafeArea()
             .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
                 scrollOffset = value
             }
             
             // 顶部白色背景栏
//             topBar
         }
     }
     
     private var topBar: some View {
         HStack {
             // 头像
             Image(.background10)
                 .resizable()
                 .scaledToFill()
                 .frame(width: 40, height: 40)
                 .clipShape(Circle())
             
             Spacer()
             
             // 名称
             Text("Ryice")
                 .bold()
             
             Spacer()
         }
         .padding()
         .background(Color.white.opacity(topBarOpacity))
         .animation(.easeInOut(duration: 0.2), value: topBarOpacity)
     }
     
     // 将计算属性移到这里
     public var topBarOpacity: Double {
         let threshold: CGFloat = -100
         
         if scrollOffset < threshold {
             return Double(min(1, abs(scrollOffset + threshold) / 100))
         } else {
             return 0
         }
     }
     
     public var avatarScale: CGFloat {
         let scale = 1 - min(1, max(0, -scrollOffset - 100) / 100)
         return max(0.6, scale)
     }
     
     public var avatarOpacity: Double {
         return Double(1 - min(1, max(0, -scrollOffset - 150) / 50))
     }
     
     public var infoOpacity: Double {
         return Double(1 - min(1, max(0, -scrollOffset - 100) / 100))
     }
     
 }
 
 #Preview {
     ProfileView()
 }
 
 @ViewBuilder
 func imageUserView(scrollOffset: Binding<CGFloat>) -> some View {
     GeometryReader { geo in
         let minY = geo.frame(in: .global).minY
         let isScrolling = minY > 0
         let offsetY = isScrolling ? -minY : 0
         let scale = isScrolling ? 1 + minY / 1000 : 1
        
         ZStack(alignment: .top) {
             // Background Image
             Image(.background2)
                 .resizable()
                 .aspectRatio(contentMode: .fill)
                 .frame(width: UIScreen.main.bounds.width) // Fixed width
                 .frame(height: max(160 + minY, 160))
                 .clipped()
                 .offset(y: offsetY)
                 .scaleEffect(scale)
             
             VStack(spacing: 0) {
                 // Avatar
                 ZStack {
                     Image(.background10)
                         .resizable()
                         .scaledToFill()
                     Circle().stroke(lineWidth: 6)
                 }
                 .frame(width: 110, height: 110)
                 .clipShape(Circle())
                 .overlay(Circle().stroke(Color.white, lineWidth: 4))
                 .background(Circle().fill(Color.white))
                 .offset(y: min(0, -scrollOffset.wrappedValue - 110))
                 .scaleEffect(ProfileView().avatarScale) // 使用 ProfileView 的计算属性
                 .opacity(ProfileView().avatarOpacity) // 使用 ProfileView 的计算属性
                 .zIndex(1)
                 
                 // User Info
                 VStack(spacing: 6) {
                   Text("Ryice\(minY)").bold().font(.title)
                     Text("The image is in 8K,ultra-HD,super-resolution,offering a glimpse into a moment of intense emotion and natural power,Picture a vast grassland where a girl stands. As the storm ")
                         .font(.callout)
                         .multilineTextAlignment(.center)
                         .frame(width: geo.size.width - 30)
                         .lineLimit(3)
                 }
            
                 .offset(y: min(0, -scrollOffset.wrappedValue - 110))
                 .opacity(ProfileView().infoOpacity) // 使用 ProfileView 的计算属性
             }
             .offset(y: 215)
         }
     }
     .frame(height: 385)
 }
 
 struct GridUserView: View {
     var body: some View {
         LazyVGrid(columns: Array(repeating: GridItem(), count: 2)) {
             ForEach(0..<25) { item in
                 RoundedRectangle(cornerRadius: 20)
                     .frame(width: 180, height: 220)
                     .foregroundStyle(.ultraThinMaterial)
             }
         }
         .padding(.horizontal, 10)
     }
 }
 
 struct ScrollOffsetPreferenceKey: PreferenceKey {
     static var defaultValue: CGFloat = 0
     static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
         value = nextValue()
     }
 }
 
 // End of file. No additional code.
