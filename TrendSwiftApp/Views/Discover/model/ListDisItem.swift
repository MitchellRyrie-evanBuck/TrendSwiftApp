//
//  ListDisItem.swift
//  TrendSwiftApp
//
//  Created by L Af on 2024/10/2.
//

import SwiftUI

struct Item: Identifiable, Hashable {
  var id: String = UUID().uuidString
  var title: String
  var image: UIImage?
}


var sampleItems: [Item] = [
  .init(title: "executive force", image:  UIImage(named: "background")),
  .init(title: "executive force", image:  UIImage(named: "background_2")),
  .init(title: "executive force", image:  UIImage(named: "background_3")),
  .init(title: "executive force", image:  UIImage(named: "background_4")),
  .init(title: "executive force", image:  UIImage(named: "background_5")),
  .init(title: "executive force", image:  UIImage(named: "background_6")),
  .init(title: "executive force", image:  UIImage(named: "background_7")),
  .init(title: "executive force", image:  UIImage(named: "background_8")),
  .init(title: "executive force", image:  UIImage(named: "background_9")),
  .init(title: "executive force", image:  UIImage(named: "background_10"))
]
