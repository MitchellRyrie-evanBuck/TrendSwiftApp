//
//  InfiniteScrollScreen.swift
//  TrendSwiftApp
//
//  Created by L Af on 2024/10/23.
//

import SwiftUI

struct InfiniteScrollScreen: View {
  @Binding var logos: [String]
  @State private var offset: CGFloat = 0
  let Width: CGFloat
  let Hieght : CGFloat
  let spacing: CGFloat = 5

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
  FirstScreen()
}
