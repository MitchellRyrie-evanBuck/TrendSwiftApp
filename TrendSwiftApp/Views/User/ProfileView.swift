//
//  ProfileView.swift
//  TrendSwiftApp
//
//  Created by L Af on 2024/10/1.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
      ScrollView{
        VStack{
          imageUserView()
          GridUserView()
        }
      }
      .ignoresSafeArea()
    }
}

#Preview {
    ProfileView()
}

@ViewBuilder
func imageUserView() -> some View {
  GeometryReader{ geo in
    let minY = geo.frame(in: .global).minY
    let iscrolling = minY > 0
    VStack {
      Image(.ver5).resizable().scaledToFill()
        .frame(height: iscrolling ? 160 + minY : 160)
        .clipped()
        .offset(y: iscrolling ? -minY : 0)
        .blur(radius: iscrolling ? 0 + minY / 80 : 0)
        .scaleEffect(iscrolling ? 1 + minY / 2000 : 1)
        .overlay(alignment: .bottom){
          ZStack{
            Image(.background10).resizable().scaledToFill()
            Circle().stroke(lineWidth: 6)
          }
          .frame(width: 110, height: 110)
            .clipShape(Circle())
            .offset(y: 50)
            .offset(y: iscrolling ? -minY : 0)
        }
      Group{
        VStack(spacing: 6){
          Text("Ryice").bold().font(.title)
          Text("The image is in 8K,ultra-HD,super-resolution,offering a glimpse into a moment of intense emotion and natural power,Picture a vast grassland where a girl stands. As the storm ").font(.callout)
            .multilineTextAlignment(.center)
            .frame(width: geo.size.width - 30)
            .lineLimit(3)
            .fixedSize()
        }
        .offset(y: iscrolling ? -minY : 0)
      }
      .padding(.vertical, 50)
    }
  }
  .frame(height: 385)
}


struct GridUserView: View {
  var body: some View {
    LazyVGrid(columns: Array(repeating: GridItem(), count: 2), content: {
      ForEach(0 ..< 25) {item in
        RoundedRectangle(cornerRadius: 20)
          .frame(width: 180,height: 220)
          .foregroundStyle(.ultraThinMaterial)
      }
    })
    .padding(.horizontal,10)
  }
}
