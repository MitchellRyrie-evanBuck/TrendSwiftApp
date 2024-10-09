//
//  AddPostView.swift
//  TrendSwiftApp
//
//  Created by L Af on 2024/10/1.
//

import SwiftUI

struct WordItem: Identifiable{
  let id: Int
  let image: ImageResource
  var offset: CGFloat = 0
  var zIndex: Double
}

struct WordView: View {
  @State private var selectedIndex = 0
  @Binding private var selectedCardIndex: Int
  @State private var items: [WordItem]
  let imageSize: CGSize
  let maximumOffset: CGFloat
  
  init(images: [ImageResource], selectedCardIndex: Binding<Int>? = nil,
       imageSize: CGSize = CGSize(width: 100, height: 150)){
    var createdItems = [WordItem]()
    for(id, image) in images.enumerated(){
      createdItems
        .append(WordItem(id:id, image:image, zIndex: Double(images.count - 1 - id) ))
    }
    self._selectedCardIndex = selectedCardIndex ?? .constant(0)
    self.items = createdItems
    self.imageSize = imageSize
    self.maximumOffset = imageSize.width * 0.75
  }
  
  // 计算旋转角度
  func calculateRotation(for item: WordItem, selectedIndex: Int, maximumOffset: CGFloat, items: [WordItem]) -> Angle {
      let offsetFactor = items[selectedIndex].offset / maximumOffset
      let baseAngle: CGFloat
      
      if item.id == selectedIndex {
          // 选中的项，根据偏移量调整角度
          baseAngle = item.offset / maximumOffset * 10
      } else {
          // 偶数和奇数项有不同的旋转方向
          baseAngle = item.id % 2 == 0
              ? 15 * (1 - abs(offsetFactor))
              : -15 * (1 - abs(offsetFactor))
      }
      
      return .degrees(baseAngle)
  }

  // 计算旋转的锚点
  func calculateAnchor(for item: WordItem) -> UnitPoint {
      return item.id % 2 == 0 ? .bottomLeading : .bottomTrailing
  }
  
    var body: some View {
      ZStack{
        ForEach(items){ item in
          Image(item.image)
            .resizable()
            .scaledToFill()
            .frame(width: imageSize.width,height: imageSize.height)
            .clipShape(.rect(cornerRadius: imageSize.height * 0.05))
            .overlay{
              RoundedRectangle(cornerRadius: imageSize.height * 0.05)
                .stroke(.white.opacity(0.2), lineWidth: 4)
                .padding(-1.5)
            }
            .offset(x:item.offset)
            .zIndex(item.zIndex)
            .rotation3DEffect(.degrees( item.offset / maximumOffset * -25.0 ),  axis: ( x: 0.0, y: 1.0, z: 0.0 ) )
          
            .rotationEffect(calculateRotation(for: item, selectedIndex: selectedIndex, maximumOffset: maximumOffset, items: items),
                            anchor: calculateAnchor(for: item))
            .scaleEffect(
              item.id == selectedIndex ? CGSize( width: 1 - ( abs(item.offset / maximumOffset) *
                0.5 ),height: 1 - ( abs(item.offset / maximumOffset) * 0.3 )) : CGSize( width: 0.8 + (0.2 * abs(items[selectedIndex].offset / maximumOffset)), height: 0.8 + (0.2 *                                     abs(items[selectedIndex].offset / maximumOffset))))
            .offset(x: item.offset / 4)
            .containerShape(Rectangle())
            .gesture(
              item.id != selectedIndex ? nil : DragGesture()
                .onChanged({ value in
                  withAnimation(.linear(duration: 0.1)){
                    if abs(value.translation.width) <= maximumOffset{
                      items[selectedIndex].offset = value.translation.width
                      withAnimation{
                        items[selectedIndex].zIndex = Double(items.count - 1)
                      }
                    }else{
                      items[selectedIndex].zIndex = 0
                    }
                  }
                })
                .onEnded({ value in
                  if abs(value.translation.width) > maximumOffset{
                    items.forEach { items[$0.id].zIndex += 1 }
                    items[selectedIndex].zIndex = 0
                  }
                  withAnimation{
                    items[selectedIndex].offset = .zero
                    selectedIndex = items
                      .first(where: { $0.zIndex == Double(items.count - 1)})?.id ?? 0
                    selectedCardIndex = selectedIndex
                  }
                  
                })
            )
        }
      }
    }
  

}

#Preview {
  WordView(
    images:[.ver1], selectedCardIndex:
        .constant(1), imageSize: CGSize(width: 220, height: 320)
  )
}
