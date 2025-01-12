//
//  ScrollViewMagic.swift
//  TrendSwiftApp
//
//  Created by L Af on 2025/1/12.
//

import SwiftUI

struct ScrollViewMagic: View {
    var body: some View {
      VStack {
        ScrollView(.vertical){
          VStack(spacing: 8){
            ForEach(1...20, id: \.self){ grocery in
              RoundedRectangle(cornerRadius: 24)
                .fill(.purple)
                .frame(height: 100)
                .visualEffect{ content, proxy in
                  content
                    .hueRotation(Angle(degrees: proxy.frame(in: .global).origin.y / 10))
                    .scaleEffect(
                        proxy.frame(in: .global).minY > 0
                            ? 1.0
                            : max(0.5, 1.0 + proxy.frame(in: .global).minY / 700)
                    )
//                    .offset(y: proxy.frame(in: .global).minY > 0
//                        ? -proxy.frame(in: .global).minY / 2
//                        : 0
//                    )
                    .opacity(proxy.frame(in: .global).minY > 0
                        ? 1.0
                        : max(0.6, 1.0 + proxy.frame(in: .global).minY / 500)
                    )
                    .blur(radius: proxy.frame(in: .global).minY > 0
                        ? 0
                        : min(5, abs(proxy.frame(in: .global).minY) / 100)
                    )
                }
                .overlay{
                  Text("\(grocery)")
                    .bold()
                    .foregroundStyle(.white)
                    .font(.title2)
                }
            }
          }
        }
        .padding(.horizontal, 10)
      }.background(.black)
    }
}

#Preview {
    ScrollViewMagic()
}
