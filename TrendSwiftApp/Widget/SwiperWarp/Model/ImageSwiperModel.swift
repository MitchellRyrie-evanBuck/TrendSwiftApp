//
//  nameSwiperModel.swift
//  TrendSwiftApp
//
//  Created by L Af on 2025/1/10.
//

import SwiftUI


struct SwiperDisItem: Identifiable, Hashable {
  var id: String = UUID().uuidString
  var title: String
  var name: String?
}


var swiperSampleItems: [SwiperDisItem] = [
  .init(title: "executive 1", name:  "background"),
  .init(title: "executive 2", name:  "background_2"),
  .init(title: "executive 3", name:  "background_3"),
  .init(title: "executive 4", name:  "background_4"),
  .init(title: "executive 5", name:  "background_5"),
  .init(title: "executive 6", name:  "background_6"),
  .init(title: "executive 7", name:  "background_7"),
  .init(title: "executive 8", name:  "background_8"),
  .init(title: "executive 9", name:  "background_9"),
  .init(title: "executive 0", name:  "background_10")
]


#Preview {
  SwiperWarp()
}
