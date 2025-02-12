//
//  UpdatePrompt.swift
//  TrendSwiftApp
//
//  Created by 刘孝文 on 2025/2/12.
//

import SwiftUI
import SwiftNEW

struct UpdatePrompt: View {
    
    @State var preview: String = "Simple"
    
    // MARK: All States
    @State var showNew: Bool = false

    
    var simple: some View {
        SwiftNEW(show: $showNew)
    }
    
    var mini: some View {
        // MARK: Mini (Toolbar / List only)
        List {
            Section(header: Text("Compatible with Toolbar / List")) {
                SwiftNEW(show: $showNew, size: .constant("mini"))
            }
        }
    }
    
    var invisible: some View {
        SwiftNEW(show: $showNew, size: .constant("invisible"))
    }
    
    var remote: some View {
        // MARK: Remote (>3.0.0) - Firebase Real Time Database Demo (Compatible with json format)
        SwiftNEW(show: $showNew, labelImage: .constant("icloud"), data: .constant("https://testground-a937f-default-rtdb.firebaseio.com/.json?print=pretty"))
    }
    
    var drop: some View {
        // MARK: Drop (>3.4.0) - Recommended trigger with Remote Notification
        SwiftNEW(show: $showNew, label: .constant("Notification"), labelImage: .constant("bell.badge"), data: .constant("https://testground-a937f-default-rtdb.firebaseio.com/.json?print=pretty"), showDrop: .constant(true))
    }
    
    var body: some View {
        #if os(iOS)
        NavigationView {
            tab
        }
        .navigationViewStyle(.stack)
        #elseif os(macOS) || os(visionOS)
        tab.padding()
        #endif
    }
    
    var tab: some View {
        // MARK: Choose either one size (Simple, Mini or Invisible)
//        TabView(selection: $preview) {
//            simple
//                .tabItem {
//                    Label("Simple", systemImage: "textformat.size.larger")
//                }
//                .tag("Simple")
//            mini
//                .tabItem {
//                    Label("Mini", systemImage: "textformat.size.smaller")
//                }
//                .tag("Mini")
//            invisible
//                .tabItem {
//                    Label("Invisible", systemImage: "questionmark.square.dashed")
//                }
//                .tag("Invisible")
//            remote
//                .tabItem {
//                    Label("Remote", systemImage: "cloud")
//                }
//                .tag("Remote")
//            #if os(iOS)
//            drop
//                .tabItem {
//                    Label("Remote", systemImage: "capsule")
//                }
//                .tag("Drop")
//            #endif
//        }
//        .toolbar {
//            if preview == "Mini" {
//                SwiftNEW(show: $showNew, size: .constant("mini"))
//            }
//        }
//        .navigationTitle(preview)
        SwiftNEW(show: $showNew)
    }
}



#Preview{
    UpdatePrompt()
}
