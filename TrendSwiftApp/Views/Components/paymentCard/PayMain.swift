//
//  PayMain.swift
//  TrendSwiftApp
//
//  Created by L Af on 2025/1/2.
//

import SwiftUI

struct PayMain: View {
    var body: some View {
      GeometryReader{
        let size = $0.size
        let safeArea = $0.safeAreaInsets
        
        paymentCard(size: size, safeArea: safeArea)
          .ignoresSafeArea(.container, edges: .top)
      }
    }
}

#Preview {
    PayMain()
}
