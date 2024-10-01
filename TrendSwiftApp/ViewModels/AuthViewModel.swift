//
//  AuthViewModel.swift
//  TrendSwiftApp
//
//  Created by L Af on 2024/10/1.
//

import SwiftUI
import Combine

class AuthViewModel: ObservableObject {
    @Published var isAuthenticated: Bool = false
    
    init() {
        // 从 UserDefaults 中读取保存的认证状态
        self.isAuthenticated = UserDefaults.standard.bool(forKey: "isAuthenticated")
    }
    
  func login(username: String, password: String) {
      if !username.isEmpty && !password.isEmpty {
          self.isAuthenticated = true
          UserDefaults.standard.set(true, forKey: "isAuthenticated")
          UserDefaults.standard.synchronize() // 强制同步保存
      }
  }

  func logout() {
      self.isAuthenticated = false
      UserDefaults.standard.set(false, forKey: "isAuthenticated")
      UserDefaults.standard.synchronize() // 强制同步保存
  }
}
