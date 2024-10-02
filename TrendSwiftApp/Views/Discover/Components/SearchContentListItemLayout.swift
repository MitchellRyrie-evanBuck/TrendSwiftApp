//
//  SearchContentListItemLayout.swift
//  TrendSwiftApp
//
//  Created by L Af on 2024/10/2.
//

import SwiftUI

struct SearchContentListItemLayout: View {
  var images: [ImageResource]
  @State var show = false
  @Namespace var namespace
  @State var selectedImage: ImageResource? = nil
  var body: some View{
    ScrollView{
      LazyVGrid(columns: Array(repeating: GridItem(), count: 2), spacing: 0 ){
        VStack{
          createGrid(for: images.filter{!isHeavy($0)})
          Spacer()
        }
        .zIndex(images.contains(where: isHeavy) ? 0: 1 )
        
        VStack{
          createGrid(for: images.filter{isHeavy($0)})
          Spacer()
        }
        .zIndex(images.contains(where: isHeavy) ? 1: 0 )
      }
    }
    .safeAreaPadding(.horizontal, 10)
    .overlay{
      if show {
        SearchImgView(imageN: selectedImage!, show:  $show, namespace: namespace)
      }
    }
  }
  
  func createGrid(for filteredImages: [ImageResource] ) -> some View {
    ForEach(filteredImages, id: \.self ){ item in
      GridRow{
        Image(item).resizable().scaledToFit()
          .clipShape(.rect(cornerRadius: 10))
          .matchedGeometryEffect(id: item, in: namespace)
          .zIndex(selectedImage == item ? 1:0)
      }
      .onTapGesture {
        withAnimation(.spring(duration: 0.5)){
          selectedImage = item
//          show.toggle()
        }
      }
    }
  }
  
  func isHeavy(_ image: ImageResource) -> Bool{
    if let index = images.firstIndex(of: image){
      return index % 2 == 1
    }
    return false
  }
  
}

#Preview {
  let images: [ImageResource] = [
    .ver2, .user2, .background, .ver1,.ver3,.ver4,.ver5
  ]
    SearchContentListItemLayout(images:images)
}
