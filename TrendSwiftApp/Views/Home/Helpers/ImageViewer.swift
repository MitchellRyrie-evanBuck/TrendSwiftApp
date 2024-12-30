//
//  ImageViewer.swift
//  TrendSwiftApp
//
//  Created by L Af on 2024/12/30.
//

import SwiftUI

struct ImageViewer<Content: View, Overlay: View>: View {
  // Config
  var config = Config()
  @ViewBuilder var content: Content
  @ViewBuilder var overlay: Overlay
  var updates: (Bool, AnyHashable?) -> () = { _, _ in }
  // View Properties
  @State private var isPresented: Bool = false
  @State private var activeTabID: AnyHashable = ""
  @State private var transitionSource: Int = 0
  
  @Namespace private var animation
  var body: some View {
    Group(subviews: content) { collection in
      LazyVGrid( columns: Array(repeating: GridItem(spacing: config.spacing), count: 2),
       spacing: config.spacing
      ){
        let remainingCount = max(collection.count - 4, 0)
        ForEach(collection.prefix(4)){ item in
          let index = collection.index(item.id)
          GeometryReader {
            let size = $0.size
            
            item
              .aspectRatio(contentMode: .fill)
              .frame(width: size.width, height: size.height)
              .clipShape(.rect(cornerRadius: config.cornerRadius))
            
            if collection.prefix(4).last?.id == item.id && remainingCount > 0 {
              RoundedRectangle(cornerRadius: config.cornerRadius)
                .fill(.black.opacity(0.35))
                .overlay{
                  Text("+\(remainingCount)")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                }
            }
          }
          .frame(height: config.height)
          .frame(maxWidth: .infinity)
          .onTapGesture {
            activeTabID = item.id
            isPresented = true
            transitionSource = index
          }
          .matchedTransitionSource(id: index, in: animation){ config in
            config.clipShape(.rect(cornerRadius: self.config.cornerRadius))
          }
        }
      }
      .navigationDestination(isPresented: $isPresented){
        TabView(selection: $activeTabID){
          ForEach(collection) { item in
            item
              .aspectRatio(contentMode: .fit)
              .frame(
                maxWidth: .infinity,
                maxHeight: .infinity
              )
      
              .tag(AnyHashable(item.id))
          }
        }
        .tabViewStyle(.page)
        .background{
          Rectangle()
            .fill(.black)
            .ignoresSafeArea()
        }
        .overlay{
          overlay
        }
        .navigationTransition(.zoom(sourceID: transitionSource, in: animation))
        .toolbarVisibility(.hidden, for: .navigationBar)
       
      }
      .onChange(of: activeTabID) { oldValue, newValue in
        if let id = newValue as? Subview.ID {
          transitionSource = min(collection.index(id), 3)
          sendUpdate(collection, id: newValue)
        }
      }
      .onChange(of: isPresented) { oldValue, newValue in
        sendUpdate(collection, id: activeTabID)
      }
    }
  }
  
  private func sendUpdate(_ collection: SubviewsCollection, id: AnyHashable?){
    if let viewID = collection.first(
      where: { $0.id == id as! Subview.ID
      })?.containerValues.activeViewID{
      updates(isPresented, viewID)
    }
  }
  
  struct Config {
    var height: CGFloat = 159
    var cornerRadius: CGFloat = 15
    var spacing: CGFloat = 10
  }
}

extension ContainerValues {
  @Entry var activeViewID: AnyHashable?
}

#Preview {
  PostContext()
}

extension SubviewsCollection {
  func index(_ id: SubviewsCollection.Element.ID) -> Int {
    firstIndex(where: { $0.id == id }) ?? 0
  }
}
