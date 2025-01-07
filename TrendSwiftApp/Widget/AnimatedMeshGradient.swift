//
//  AnimatedMeshGradient.swift
//  TrendSwiftApp
//
//  Created by L Af on 2025/1/8.
//

import SwiftUI

struct AnimatedMeshGradient: View {
  @State var appear = false
  @State var appear2 = false
  var purpleBlue: Color {
    Color.purple.opacity(0.7)
  }
    var body: some View {
      MeshGradient(
        width: 3,
        height: 3,
        points: [
          [0.0,0.0],   [ appear2 ? randomFloat() : 1.0, 0.0],   [1.0,0.0],
          [0.0,randomFloat()], appear ? [randomFloat(), randomFloat()] : [0.8, randomFloat()], [1.0, -0.5],
          [0.0,1.0],   [1.0 , appear2 ? 2.0 : 1.0],   [1.0,1.0],
        ],
        colors: [
          appear2 ? .red : .mint , appear2 ? .yellow : .cyan, .orange,
          appear ? .blue : .red, appear ? .cyan : purpleBlue, appear ? .red : .purple,
          appear ? .red : .cyan  ,appear ? .mint : .blue, appear2 ? .red : .blue
        ]
      )
      .blendMode(.normal)
      .onAppear{
        withAnimation(.easeInOut(duration: 1).repeatForever(autoreverses: true)){
          appear.toggle()
        }
        withAnimation(.easeInOut(duration: 2).repeatForever(autoreverses: true)){
          appear2.toggle()
        }
      }
    }
  
  func randomFloat() -> Float {
      return Float.random(in: 0.0...1.0)
  }
}

#Preview {
    AnimatedMeshGradient()
    .ignoresSafeArea()
}
