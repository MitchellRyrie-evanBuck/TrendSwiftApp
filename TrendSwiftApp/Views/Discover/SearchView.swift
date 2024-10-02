//
//  SearchView.swift
//  TrendSwiftApp
//
//  Created by L Af on 2024/10/1.
//

import SwiftUI

struct SearchView: View {
  let images: [ImageResource] = [
    .ver2, .user2, .background, .ver1,.ver3,.ver4,.ver5
  ]
  
  var body: some View{
    SearchContentListItemLayout(images: images)
  }
}

#Preview {
  SearchView()
}
