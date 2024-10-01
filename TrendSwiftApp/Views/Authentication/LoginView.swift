//
//  LoginView.swift
//  TrendSwiftApp
//
//  Created by L Af on 2024/10/1.
//

import SwiftUI

struct LoginView: View {
  @State private var username = ""
      @State private var password = ""
      @EnvironmentObject var authViewModel: AuthViewModel
      
      var body: some View {
          VStack {
              Text("Instagram")
                  .font(.largeTitle)
              
              TextField("Username", text: $username)
                  .textFieldStyle(RoundedBorderTextFieldStyle())
                  .padding()
              
              SecureField("Password", text: $password)
                  .textFieldStyle(RoundedBorderTextFieldStyle())
                  .padding()
              
              Button("Log In") {
                  authViewModel.login(username: username, password: password)
              }
              .padding()
              
              Button("Switch accounts") {
                  // 切换账号逻辑
              }
              
              Spacer()
              
              Button("Sign up") {
                  // 注册逻辑
              }
          }
          .padding()
      }
}

#Preview {
    LoginView()
}
