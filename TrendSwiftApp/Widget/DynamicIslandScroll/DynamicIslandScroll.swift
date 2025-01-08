//
//  DynamicIslandScroll.swift
//  TrendSwiftApp
//
//  Created by L Af on 2025/1/8.
//

import SwiftUI

struct DynamicIslandHome: View {
  var size: CGSize
  var safeArea: EdgeInsets
  
  @State private var scrollProgress: CGFloat = 0
  @Environment(\.colorScheme) private var colorScheme
  @State private var textHeaderOffset: CGFloat = 0
  var body: some View{
    let isHavingNotch = safeArea.bottom != 0
    ScrollView(.vertical, showsIndicators: true){
      VStack(spacing: 12){
        Image(.user)
          .resizable()
          .aspectRatio(contentMode: .fill)
          // 基于滚动进度添加模糊和缩小大小
          .frame(width: 130 - ( 75 * scrollProgress ) , height: 130 - ( 75 * scrollProgress ))
          // Hiding Main View so that the Dynmaic Island Metaball Effect will be Visible
          .opacity(1 - scrollProgress)
          .blur(radius: scrollProgress * 10, opaque: true )
          .clipShape(Circle())
          .anchorPreference(key: AnchorKey.self, value: .bounds, transform: {
            return ["HEADER": $0 ]
          })
          .padding(.top, safeArea.top + 15)
          .offsetExtractor(coordinateSpace: "SCROLLVIEW"){ scrollRect in
            guard isHavingNotch else {
              return
            }
            let progress = -scrollRect.minY / 25
            scrollProgress = min(max(progress, 0), 1)
            
          }
        
        let fixedTop: CGFloat = safeArea.top + 3
        Text("Mitchell Ryrie")
          .font(.caption)
          .foregroundStyle(.gray)
          .padding(.vertical, 15)
          .background( content: {
            Rectangle()
              .fill(colorScheme == .dark ? .black : .white)
              .frame(width: size.width)
              .padding(.top, textHeaderOffset < fixedTop ? -safeArea.top : 0 )
              .shadow(color: .black.opacity(textHeaderOffset < fixedTop ? 0.1
                  : 0), radius: 5, x: 0, y: 5)
          })
          .offset(
            y: textHeaderOffset < fixedTop ? -(textHeaderOffset - fixedTop ) : 0
          )
          .offsetExtractor(coordinateSpace: "SCROLLVIEW"){
            textHeaderOffset = $0.minY
          }
          .zIndex(1000)
        
        DynamicIslandContent(safeArea: safeArea)
      }

      .frame(maxWidth: .infinity)
    }
    // 为什么不使用overlapreference？因为对于这种效果，我们将使用Canvas，如果我们使用overlapreference，那么它将禁用我们根视图上的所有交互。这就是为什么我们使用背景偏好。
    .backgroundPreferenceValue(AnchorKey.self, { pref in
      GeometryReader{ proxy in
        if let anchor = pref["HEADER"], isHavingNotch {
          let frameRect = proxy[anchor]
          let isHavingDynamicIsland = safeArea.top > 51
          let capsuleHeight = isHavingDynamicIsland ? 37 : (safeArea.top - 15 )
          
          Canvas { out, size in
            out.addFilter(.alphaThreshold(min: 0.5))
            out.addFilter(.blur(radius: 12))
            out.drawLayer { ctx in
              if let headerView = out.resolveSymbol(id: 0){
                ctx.draw(headerView, in: frameRect)
              }
              if let dynamicIsland = out.resolveSymbol(id: 1){
                let rect = CGRect(
                  x: (size.width - 120 ) / 2,
                  y: isHavingDynamicIsland ? 11 : 0,
                  width: 120,
                  height: capsuleHeight
                )
                ctx.draw(dynamicIsland, in: rect)
              }
            }
          } symbols: {
            HeaderView(frameRect)
              .tag(0)
              .id(0)
            DynamicIslandCapsule(capsuleHeight)
              .tag(1)
              .id(1)
          }
       
        }
      }
      .overlay(alignment: .top){
        Rectangle().fill( colorScheme == .dark ? .black : .white )
          .frame(height: 15)
      }
    })
    .overlay(alignment: .top, content:{
      HStack{
        Button{
          
        } label: {
          Label("Back", systemImage: "chevron.left" )
        }
        
        Spacer()
        
        Button{
          
        } label: {
          Text("Share")
        }
      }
      .padding(15)
      .padding(.top, safeArea.top )
    })
    .coordinateSpace(name: "SCROLLVIEW")
  }
  
  @ViewBuilder
  func HeaderView(_ frameRect: CGRect) -> some View {
    Circle()
      .fill(.black)
      .frame(width: frameRect.width, height: frameRect.height)
      //.offset(x: frameRect.minX, y: frameRect.minY)
  }
  
  @ViewBuilder
  func DynamicIslandCapsule( _ height:CGFloat = 37 ) -> some View {
    Capsule()
      .fill(.black)
      .frame(width: 120, height: height)
  }
}


struct DynamicIslandContent: View {
  var safeArea: EdgeInsets
  var body: some View {
    VStack{
      ForEach(1...20, id: \.self) { _ in
        RoundedRectangle( cornerRadius: 5,style: .continuous )
          .fill(.gray.opacity(0.15))
          .frame(height: 25)
        RoundedRectangle( cornerRadius: 5,style: .continuous )
          .fill(.gray.opacity(0.15))
          .frame(height: 15)
          .padding(.trailing, 70)
        RoundedRectangle( cornerRadius: 5,style: .continuous )
          .fill(.gray.opacity(0.15))
          .padding(.trailing, 150)
      }
    }
    .padding(.horizontal, 15)
    .padding(.bottom, safeArea.bottom + 15)
  }
}


struct DynamicIslandScroll: View {
    var body: some View {
      GeometryReader{
        let size = $0.size
        let safeArea = $0.safeAreaInsets
        
        DynamicIslandHome(size: size, safeArea: safeArea)
          .ignoresSafeArea()
      }
    }
}

#Preview {
    DynamicIslandScroll()
}
