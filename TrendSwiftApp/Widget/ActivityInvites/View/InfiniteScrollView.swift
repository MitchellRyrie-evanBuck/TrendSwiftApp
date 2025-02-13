//
//  InfiniteScrollView.swift
//  TrendSwiftApp
//
//  Created by 刘孝文 on 2025/2/13.
//

import SwiftUI

struct InfiniteScrollView<Content: View>: View {
    var spacing: CGFloat = 10
    @ViewBuilder var content: Content
    @State private var contentSize: CGSize = .zero
    var body: some View {
        GeometryReader{
            let size = $0.size
            
            ScrollView(.horizontal){
                HStack(spacing: spacing){
                    Group(subviews: content) { collection in
                        HStack(spacing: spacing){
                            ForEach(collection){ view in
                                view
                            }
                        }
                        .onGeometryChange(for: CGSize.self){
                            $0.size
                        } action: { newValue in
                            contentSize = .init(width: newValue.width + spacing, height: newValue.height)
                        }
                        
                        let averageWidth = contentSize.width / CGFloat(collection.count)
                        let repeatingCount = contentSize.width > 0 ? Int((size.width / averageWidth).rounded()) + 1 : 1
                        
                        HStack(spacing: spacing){
                            ForEach(0..<repeatingCount, id: \.self){ index in
                                let view = Array(collection)[index % collection.count]
                                view
                            }
                        }
                    }
                }
            }
        }
    }
}



