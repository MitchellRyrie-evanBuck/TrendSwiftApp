//
//  MessageContent.swift
//  TrendSwiftApp
//
//  Created by L Af on 2024/10/3.
//

import SwiftUI

struct MessageContent: View {
    var body: some View {
      GeometryReader{ proxy in
        ScrollView(.vertical){
          LazyVStack(spacing: 15){
              ForEach(messages){ message in
                MessageCardView(screenProxy: proxy, message: message)
              }

          }
          .padding(15)
        }
      }
    }
}



struct MessageCardView: View {
    var screenProxy: GeometryProxy
    var message: Message
    
    var body: some View {
        Text(message.message)
            .padding(10)
            .foregroundStyle(message.isReply ? Color.primary : .white)
            .background {
                Group {
                    if message.isReply {
                      CustomRoundedRectangle(isReply: message.isReply)
                            .fill(.gray.opacity(0.3))
                    } else {
                        GeometryReader { geo in
                            let actualSize = geo.size
                            let rect = geo.frame(in: .global)
                            let screenSize = screenProxy.size
                            let safeArea = screenProxy.safeAreaInsets
                            Rectangle()
                                .fill(
                                    .linearGradient(
                                        colors: [
                                            Color("C1"),
                                            Color("C2"),
                                            Color("C3"),
                                       
                                            Color("C4"),
                                            Color("C5"),
                                        ],
                                        startPoint: .top,
                                        endPoint: .bottom
                                    )
                                )
                                .mask(alignment: .topLeading) {
                                  CustomRoundedRectangle(isReply: message.isReply)
                                        .frame(width: actualSize.width, height: actualSize.height)
                                        .offset(x: rect.minX, y: rect.minY)
                                }
                                .offset(x: -rect.minX, y: -rect.minY)
                                .frame(width: screenSize.width, height: screenSize.height + safeArea.top + safeArea.bottom)
                        }
                    }
                }
            }
            .frame(maxWidth: 250, alignment: message.isReply ? .leading : .trailing)
            .frame(maxWidth: .infinity, alignment: message.isReply ? .leading : .trailing)
    }
}

