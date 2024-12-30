//
//  PostContext.swift
//  TrendSwiftApp
//
//  Created by L Af on 2024/12/25.
//

import SwiftUI

let sampleImages: [ImagePostModel] = [
  .init(altText: "Mo, as", link: "https://images.unsplash.com/photo-1731739994975-d55f1a94cff9?q=80&w=2667&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
  .init(altText: "codsd", link: "https://images.unsplash.com/photo-1735507582615-0321c88f6dbb?q=80&w=3270&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
  .init(altText: "vsdv", link: "https://images.unsplash.com/photo-1735506266333-6786ca07c093?q=80&w=3270&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
  .init(altText: " fvd", link: "https://images.unsplash.com/photo-1735421094663-6a022f6bbe63?q=80&w=3387&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
  .init(altText: "ewfwef", link: "https://images.unsplash.com/photo-1735174573052-25f8bf469fdc?q=80&w=3260&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
  .init(altText: "dfber", link: "https://images.unsplash.com/photo-1734077457229-8017ee15c7c7?q=80&w=3271&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")
]

struct PostContext: View {
    var body: some View {
      NavigationStack{
        VStack{
          ImageViewer {
            ForEach(sampleImages) { image in
              AsyncImage(url: URL(string: image.link.trimmingCharacters(in: .whitespaces))) { image in
                image
                  .resizable()
              } placeholder: {
                Rectangle()
                  .fill(.gray.opacity(0.4))
                  .overlay {
                    ProgressView()
                      .tint(.blue)
                      .scaleEffect(0.7)
                      .frame(
                        maxWidth: .infinity,
                        maxHeight: .infinity)
                  }
              }
              .containerValue(\.activeViewID, image.id)
            }
            
          } overlay: {
            OverlayView()
          }  updates: { isPresented, activeViewID in
            print(isPresented, activeViewID)
          }
        }
        .padding(15)
          .navigationTitle("Image Viewer")
      }
    }
}

struct OverlayView: View {
  @Environment(\.dismiss) private var dismiss
  var body : some View{
    VStack{
      Button{
        dismiss()
      } label: {
        Image(systemName: "xmark.circle.fill")
          .font(.title)
          .foregroundStyle(.ultraThinMaterial)
          .padding(10)
          .contentShape(.rect)
      }
      .frame(maxWidth: .infinity,alignment: .leading)
      Spacer(minLength: 0)
    }
    .padding(15)
  }
}

#Preview {
    PostContext()
}
