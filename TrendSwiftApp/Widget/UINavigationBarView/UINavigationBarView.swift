//
//  UINavigationBarView.swift
//  TrendSwiftApp
//
//  Created by L Af on 2025/2/19.
//

import SwiftUI
import UIKit

// NavigationBar extension to remove default blur
// class CustomNavigationBar: UINavigationBar {
//  override func layoutSubviews() {
//    super.layoutSubviews()
//
//    let barBackground = subviews.first { subview in
//      type(of: subview) == NSClassFromString("_UIBarBackground")
//    }
//
//    let visualEffectView = barBackground?.subviews.first { subview in
//      type(of: subview) == NSClassFromString("UIVisualEffectView")
//    }
//
//    let backdropView = visualEffectView?.subviews.first { subview in
//      type(of: subview) == NSClassFromString("_UIVisualEffectBackdropView")
//    }
//
//    backdropView?.layer.filters?.removeAll { filter in
//      guard let filter = filter as? NSObject else { return false }
//
//      let selector = NSSelectorFromString("type")
//      guard filter.responds(to: selector) else { return false }
//
//      let type = filter.value(forKey: "type") as? String
//
//      return type != "gaussianBlur"
//    }
//  }
// }

// Add ViewController extension
// extension UIViewController {
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        let appearance = UINavigationBarAppearance()
//        appearance.backgroundEffect = UIBlurEffect.effect(blurRadius: 22.5)
//
//        navigationItem.standardAppearance = appearance
//    }
// }

// Custom NavigationBar Title View
struct CustomNavigationTitleView: View {
  var body: some View {
    HStack(spacing: 8) {
      Image(systemName: "star.fill")
        .resizable()
        .frame(width: 20, height: 20)
        .foregroundColor(.blue)

      Text("Navigation Bar")
        .font(.headline)

      Spacer()
    }
    .frame(height: 44) // Default navigation bar height
  }
}

// UINavigationBarView implementation
struct UINavigationBarView: View {
  var body: some View {
    NavigationView {
      ScrollViewMagic()
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Messages")
//        .toolbar {
//            ToolbarItem(placement: .principal) {
//                CustomNavigationTitleView()
//            }
//        }
    }
    .navigationViewStyle(StackNavigationViewStyle())
    .onAppear {
      // Setup custom navigation bar
      let appearance = UINavigationBarAppearance()
      appearance.backgroundEffect = UIBlurEffect.effect(blurRadius: 22.5)
      appearance.configureWithDefaultBackground()
      // Configure to maintain compact height
      appearance.shadowColor = .clear

      UINavigationBar.appearance().standardAppearance = appearance
      UINavigationBar.appearance().scrollEdgeAppearance = appearance
      UINavigationBar.appearance().compactAppearance = appearance
    }
  }
}

// UIBlurEffect extension for custom blur
extension UIBlurEffect {
  static func effect(blurRadius: CGFloat) -> UIBlurEffect? {
    let selector = NSSelectorFromString("effectWithBlurRadius:")

    guard responds(to: selector) else { return nil }

    let blurEffect = perform(selector, with: blurRadius).takeUnretainedValue()

    return blurEffect as? UIBlurEffect
  }
}

#Preview {
  UINavigationBarView()
}
