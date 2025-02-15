//
//  IntroPage.swift
//  TrendSwiftApp
//
//  Created by 刘孝文 on 2025/2/13.
//

import SwiftUI

struct IntroPage: View {
  @State private var activeCard: InvitesCard? = InvitesCards.first
  @State private var scrollPosition: ScrollPosition = .init()
  @State private var currentScrollOffset: CGFloat = 0
  @State private var timer = Timer.publish(
    every: 0.01,
    on: .current,
    in: .default
  ).autoconnect()
  @State private var initialAnimation: Bool = false
  @State private var titleProgress: CGFloat = 0
  @State private var scrollPhase: ScrollPhase = .idle
    var body: some View {
        ZStack{
            AmbientBackground()
            .animation(.easeInOut(duration: 1), value: activeCard)
            
            VStack(spacing: 40){
//                ScrollView(.horizontal){
//                    HStack(spacing: 10){
//
//                    }
//                }
                InfiniteScrollView {
                    ForEach(InvitesCards){ card in
                        CarouselCardView(card)
                    }
                }
                .scrollIndicators(.hidden)
                .scrollPosition($scrollPosition)
                .scrollClipDisabled()
                .containerRelativeFrame(.vertical){ value, _ in
                    value * 0.45
                }
                .onScrollPhaseChange( { oldPhass, newPhase in
                  scrollPhase = newPhase
                })
                .onScrollGeometryChange(for: CGFloat.self){
                  $0.contentOffset.x + $0.contentInsets.leading
                } action: {
 oldValue,
 newValue in
                  currentScrollOffset = newValue
                  if scrollPhase != .decelerating || scrollPhase != .animating {
                    let activeIndex = Int(
                      (currentScrollOffset / 220).rounded()
                    ) % InvitesCards.count
                    
                    activeCard = InvitesCards[activeIndex]
                  }
         
                }
                .visualEffect{ [initialAnimation] content, proxy in
                  content.offset(y: !initialAnimation ? -(proxy.size.height + 200) : 0 )
                }
              
              VStack(spacing: 4){
                Text("Welcome to")
                  .fontWeight(.semibold)
                  .foregroundStyle(.white.secondary)
                  .blurOpacityEffect(initialAnimation)
                
                Text("Apple Invites")
                  .font(.largeTitle.bold())
                  .foregroundStyle(.white)
                  .textRenderer(CustomTextEffect(progress: titleProgress ))
                  .padding(.bottom, 12)
                
                Text("Create beautiful invitations for all your events.\nAnyone can receive invitations. Sending included\n with iClound+.")
                  .font(.callout)
                  .multilineTextAlignment(.center)
                  .foregroundStyle(.white.secondary)
                  .blurOpacityEffect(initialAnimation)
              }
              Button {
                timer.upstream.connect().cancel()
              } label: {
                Text("Create Event")
                  .fontWeight(.semibold)
                  .foregroundStyle(.black)
                  .padding(.horizontal, 25)
                  .padding(.vertical, 12)
                  .background(.white, in: .capsule)
              }
              .blurOpacityEffect(initialAnimation)
            }
            .safeAreaPadding(15)
        }
        .onReceive(timer) { _ in
          currentScrollOffset += 0.35
          scrollPosition.scrollTo(x: currentScrollOffset)
        }
        .task {
          try? await Task.sleep(for: .seconds(0.35))
          
          withAnimation(.smooth(duration: 0.75, extraBounce: 0 )){
            initialAnimation = true
          }
          
          withAnimation(.smooth(duration: 2.5, extraBounce: 0 ).delay(0.3)){
            titleProgress = 1
          }
        }
    }
    
    @ViewBuilder
    private func AmbientBackground() -> some View {
        GeometryReader{
            let size = $0.size
            ZStack {
                ForEach(InvitesCards){ card in
                    Image(card.image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .ignoresSafeArea()
                        .frame(width: size.width, height: size.height)
                        .opacity(activeCard?.id == card.id ? 1 : 0)
                }
                Rectangle()
                    .fill(.black.opacity(0.45))
                    .ignoresSafeArea()
            }
            .compositingGroup()
            .blur(radius: 90, opaque: true)
            .ignoresSafeArea()
        }
    }
    
    @ViewBuilder
    private func CarouselCardView(_ card: InvitesCard) -> some View {
        GeometryReader{
            let size = $0.size
            
            Image(card.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
                .frame(width: size.width, height: size.height)
                .clipShape(.rect(cornerRadius: 20))
                .shadow(color: .black.opacity(0.4), radius: 10, x:1, y: 0)
        }
        .frame(width: 220)
        .scrollTransition(.interactive.threshold(.centered), axis: .horizontal){ content, phase in
            content.offset(y: phase == .identity ? -10 : 0)
                .rotationEffect(.degrees(phase.value * 5 ), anchor: .bottom )
        }
    }
}

#Preview {
    IntroPage()
}


extension View {
  func blurOpacityEffect(_ show: Bool) -> some View {
    self
      .blur(radius: show ? 0 : 2)
      .opacity(show ? 1 : 0)
      .scaleEffect(show ? 1 : 0.9)
  }
}
