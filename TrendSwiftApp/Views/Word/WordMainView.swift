//
//  WordMainView.swift
//  TrendSwiftApp
//
//  Created by L Af on 2024/10/9.
//

import SwiftUI

struct WordMainView: View {
  @State private var selectedIndex = 0
  let images:[ImageResource] = [.ver1,.ver2,.ver3,.ver4,.ver5]
  let colors:[Color] = [.orange, .red, .blue, .cyan, .red, Color(.label), .blue]
    var body: some View {
      
      ZStack {
        Color(colors[selectedIndex]).opacity(0.85)
          .ignoresSafeArea()
        VStack{
          Spacer()
          Text("Explore The Anime World Now")
            .multilineTextAlignment(.center)
            .font(.largeTitle)
            .bold()
            .padding(.horizontal)
          Spacer()
          WordView(
            images: images,
            selectedCardIndex: $selectedIndex,
            imageSize: CGSize(
              width: 220,
              height: 320
            )
          )
          Spacer()
        }.padding()
      }
    }
}

#Preview {
    WordMainView()
}
