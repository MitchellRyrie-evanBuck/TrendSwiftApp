//
//  SplashScreen.swift
//  TrendSwiftApp
//
//  Created by L Af on 2025/2/11.
//

import SwiftUI
import SplashScreenKit

struct SplashScreenWidget: View {
  var body: some View {
    SplashScreen(
        images: [
            Photo("Apple TV 1"),
            Photo("Apple TV 2"),
            Photo("Apple TV 3"),
            Photo("Apple TV 4"),
            Photo("Apple TV 5"),
            Photo("Apple TV 6")
        ],
        title: "Welcome to",
        product: "Apple TV",
        caption: "Browse all movies, TV shows, and more from Apple TV+. Watch all Apple Originals here.",
        cta: "Watch Now"
    ) {
        // Button Action
        print("Hello, Apple TV!")
    }
  }
}

#Preview {
  SplashScreenWidget()
}
