//
//  OffsetKey.swift
//  TrendSwiftApp
//
//  Created by L Af on 2025/1/8.
//

import SwiftUI

struct OffsetKey: PreferenceKey {
  static var defaultValue: CGRect = .zero
  static func reduce(value: inout CGRect, nextValue: () -> CGRect ){
    value = nextValue()
  }
}

extension View {
  @ViewBuilder
  func offsetExtractor( coordinateSpace: String, completion: @escaping (CGRect) -> ()) -> some View {
    self
      .overlay {
          GeometryReader {
            let rect = $0.frame(in:.named(coordinateSpace))
            Color.clear
              .preference(key: OffsetKey.self, value: rect)
              .onPreferenceChange(OffsetKey.self, perform: completion)
      }
    }
  }
}

#Preview {
  DynamicIslandScroll()
}
