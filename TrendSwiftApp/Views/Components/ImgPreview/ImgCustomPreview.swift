//
//  ImgCustomPreview.swift
//  TrendSwiftApp
//
//  Created by L Af on 2024/10/2.
//

import SwiftUI

struct pageModel: Identifiable {
  var id = UUID()
  var page: AnyView
}

struct CustomTransition: View {
  @State var show = false
  @State var currentIndex = 0
  @State var isGoingBack = false
  
  let pages: [pageModel]
  let numberOfRectangles: Int
  
  var body:some View {
    GeometryReader{ geo in
      ZStack{
        if currentIndex < pages.count{
          pages[currentIndex].page
            .frame(width: geo.size.width, height: geo.size.height)
          pages[max(0,min(currentIndex+(isGoingBack ? -1:1), pages.count - 1 ))].page
            .frame(width: geo.size.width, height: geo.size.height)
            .mask{
              VStack(spacing: 0 ){
                ForEach(0..<numberOfRectangles,  id: \.self){ index in
                  Rectangle()
                    .frame(
                      height: geo.size.height / CGFloat(numberOfRectangles)
                    )
                    .offset(
                      x: show ? 0 : (
                        index % 2 == 0 ? (
                          isGoingBack ? geo.size.height : -geo.size
                            .height) : (
                              isGoingBack ? -geo.size.height : geo.size
                                .height)
                      )
                    )
                  
                }
              }
            }
          
        }
        if currentIndex < pages.count - 1 {
          HStack{
            if currentIndex != 0 {
              CustomButton(title: "Back", action: {
                Back()
              })
            }
         
        
            Spacer()
            CustomButton(title: "Next", action: {
              Next()
            })
          }
          .padding()
          .frame(maxHeight: .infinity, alignment: .bottom)
        }
      }
    }
    .ignoresSafeArea()
  }
  
  func Back(){
    isGoingBack = true
    withAnimation{
      show.toggle()
    }
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
      if show {
        if currentIndex > 0 {
          currentIndex -= 1
        }
        show.toggle()
      }
    }
  }
  
  func Next(){
    isGoingBack = true
    withAnimation{
      show.toggle()
    }
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
      if show {
        if currentIndex < pages.count - 1 {
          currentIndex += 1
        }
        show.toggle()
      }
    }
  }
}



struct ImgCustomPreview: View {
    var body: some View {
      Text("0000").font(.largeTitle)
        .foregroundStyle(.blue)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
    }
}

#Preview {
  let pages: [pageModel] = [
    pageModel(page: AnyView(Image("ver_1").resizable().scaledToFill())),
    pageModel(page: AnyView(Image("ver_2").resizable().scaledToFill())),
    pageModel(page: AnyView(Image("ver_3").resizable().scaledToFill())),
    pageModel(page: AnyView(Image("ver_4").resizable().scaledToFill())),
    pageModel(page: AnyView(Image("ver_5").resizable().scaledToFill())),
    pageModel(page: AnyView(ImgCustomPreview()))
  ]
  return CustomTransition(pages: pages, numberOfRectangles: 3 )
}


struct CustomButton: View {
  var title: String
  var action: () -> Void
  var body: some View{
    Button(action: {
      action()
    }, label: {
      Text(title)
        .padding()
        .background(.black.opacity(0.7), in: .rect(cornerRadius: 12))
    }).tint(.white).padding()
  }
}
