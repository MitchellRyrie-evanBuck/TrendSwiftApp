//
//  ContentView.swift
//  TrendSwiftApp
//
//  Created by L Af on 2024/9/28.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        Group {
            if authViewModel.isAuthenticated {
                MainView()
              
            } else {
                CardFor3D()
//              FirstScreen()
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AuthViewModel()) // 在预览中注入 AuthViewModel
    }
}
