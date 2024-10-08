//
//  TrendSwiftAppApp.swift
//  TrendSwiftApp
//
//  Created by L Af on 2024/9/28.
//

import SwiftUI

@main
struct TrendSwiftAppApp: App {
  @StateObject private var authViewModel = AuthViewModel()
  
  var body: some Scene {
      WindowGroup {
          ContentView()
              .environmentObject(authViewModel)
      }
  }
}
