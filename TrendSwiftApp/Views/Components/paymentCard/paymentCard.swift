//
//  paymentCard.swift
//  TrendSwiftApp
//
//  Created by L Af on 2025/1/2.
//

import SwiftUI

struct paymentCard: View {
  var size: CGSize
  var safeArea: EdgeInsets
  
  @State private var showDetailView: Bool = false
  @State private var selectedCard: PaymentCardModel?
  @Namespace private var animation
  
    var body: some View {
      ScrollView(.vertical) {
        LazyVStack(spacing: 0){
          Text("My Wallet")
            .font(.title2.bold())
            .frame(maxWidth: .infinity)
            .overlay(alignment: .trailing) {
              Button{
                
              } label: {
                Image(.user2)
                  .resizable()
                  .aspectRatio(contentMode: .fill)
                  .frame(width: 35,height: 35)
                  .clipShape(.circle)
              }
            }
            .blur(radius: showDetailView ? 5 : 0)
            .opacity(showDetailView ? 0 : 1)
          
            // Card
          let mainOffset = CGFloat(
            PaymentCards.firstIndex(where: { $0.id == selectedCard?.id }) ?? 0
          ) * -size.width
          
          LazyVStack(spacing: 10) {
            ForEach(PaymentCards) { card in
              
              let cardOffset = CGFloat(
                PaymentCards.firstIndex(where: { $0.id == card.id }) ?? 0
              ) * size.width
              
              CardPayView(card)
                .frame(width: showDetailView ? size.width : nil)
                .visualEffect {[showDetailView] content, proxy in
                  content
                    .offset(x: showDetailView ? cardOffset : 0 ,y:
                              showDetailView ? -proxy.frame(in:
                          .scrollView).minY : 0)
                }
            }
          }
          .padding(.top, 25)
          .offset(x: showDetailView ? mainOffset : 0)
        }
        .safeAreaPadding(15)
        .safeAreaPadding(.top, safeArea.top)
      }
      .scrollDisabled(showDetailView)
      .scrollIndicators(.hidden)
      .overlay {
        if let selectedCard, showDetailView{
          DetailView(selectedCard: selectedCard)
            .padding(.top, expandedCardHeight)
            .transition(.move(edge: .bottom))
        }
      }
    }
  
  @ViewBuilder
  func CardPayView(_ card: PaymentCardModel) -> some View{
    ZStack{
      Rectangle().fill(card.color.gradient)
      
      VStack(alignment: .leading, spacing: 15){
        if !showDetailView {
          VisaImageView(card.visaGeometryID, height: 20)
        }
        
        VStack(alignment: .leading, spacing: 4){
          Text(card.number)
            .font(.caption)
            .foregroundStyle(.white.secondary)
          Text("$3823.89")
            .font(.title2.bold())
            .foregroundStyle(.white)
        }
        .frame(
          maxWidth: .infinity,
          maxHeight: .infinity,
          alignment: showDetailView ? .center: .leading
        )
        .overlay{
          ZStack{
            if showDetailView {
              VisaImageView(card.visaGeometryID, height: 10)
                .frame(maxWidth: .infinity, alignment: .leading)
                .offset(y: 45)
            }
            if let selectedCard, selectedCard.id == card.id, showDetailView {
              Button{
                withAnimation(.smooth(duration: 0.5, extraBounce: 0 )){
                  self.selectedCard = nil
                  showDetailView = false
                }
              } label: {
                Image(systemName: "chevron.left")
                  .font(.title3.bold())
                  .foregroundStyle(.white)
                  .contentShape(.rect)
              }
              .frame(maxWidth: .infinity,alignment: .leading)
              .transition(.asymmetric(insertion: .opacity, removal: .identity))
            }
        
          }
        }
        .padding(.top, showDetailView ? safeArea.top - 10 : 0)
        HStack{
          Text("Expires: \(card.expires)")
            .font(.caption)
          Spacer()
          Text("IJUSTIANE")
            .font(.callout)
          
    
        }
        .foregroundStyle(.white.secondary)
      }
      .padding( showDetailView ? 15 : 25)
    }
    .frame(height: showDetailView ? expandedCardHeight : nil)
    .frame(height: 200, alignment: .top)
    .clipShape(.rect(cornerRadius: showDetailView ? 0 : 25))
    .onTapGesture {
      guard !showDetailView else { return }
      withAnimation(.smooth(duration: 0.5, extraBounce: 0)){
        selectedCard = card
        showDetailView = true
      }
    }
  }
  
  @ViewBuilder
  func VisaImageView(_ id: String, height: CGFloat) -> some View {
    Image(.visa)
      .resizable()
      .aspectRatio(contentMode: .fit)
      .matchedGeometryEffect(id: id, in: animation)
      .frame(height: height)
  }
  
  var expandedCardHeight: CGFloat {
    safeArea.top + 130
  }
}

struct DetailView: View{
  var selectedCard: PaymentCardModel
  var body: some View {
    ScrollView(.vertical){
      LazyVStack(spacing: 0){
        ForEach(1...20, id: \.self){ _ in
          RoundedRectangle(cornerRadius: 15)
            .fill(.gray.gradient)
            .frame(height: 125)
            .foregroundStyle(.gray.gradient)
        }
        .padding(10)
      }
    }
  }
}


#Preview {
  PayMain()
}
