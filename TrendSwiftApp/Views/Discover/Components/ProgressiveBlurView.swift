//
//  ProgressiveBlurView.swift
//  TrendSwiftApp
//
//  Created by L Af on 2024/10/2.
//

import SwiftUI

struct ProgressiveBlurView: UIViewRepresentable {
  func makeUIView(context: Context) -> CustomBlurView {
    let view = CustomBlurView()
    view.backgroundColor = .clear
    return view
    
  }
  func updateUIView(_ uiView: CustomBlurView, context: Context) {
      
  }
}

class CustomBlurView: UIVisualEffectView {
  init(){
    super.init(effect: UIBlurEffect(style: .systemThinMaterial))
    
    removeFilters()
    
    registerForTraitChanges([UITraitUserInterfaceStyle.self]){ (self:Self,_) in
      
      DispatchQueue.main.async {
        self.removeFilters()
      }
    }
  }
  
  private func removeFilters(){
    if let filterLayer = layer.sublayers?.first{
      filterLayer.filters = []
    }
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
