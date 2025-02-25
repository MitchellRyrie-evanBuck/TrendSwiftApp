//
//  AnchorKey.swift
//  TrendSwiftApp
//
//  Created by L Af on 2025/1/8.
//

import SwiftUI

struct AnchorKey: PreferenceKey {
  static var defaultValue: [String:Anchor<CGRect>] = [:]
  static func reduce(
    value: inout [String : Anchor<CGRect>],
    nextValue: () -> [String : Anchor<CGRect>]
  ) {
    value.merge(nextValue()){
      $1
    }
  }
}

