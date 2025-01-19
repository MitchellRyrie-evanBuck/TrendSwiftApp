

import SwiftUI

struct TextWidget: View {
    var body: some View {
      
      HStack {
        Text("Generating...")
          .foregroundStyle(.white)
          .font(.title2)
      }
      .padding(.vertical, 16)
      .frame(maxWidth: 370)
      .background(
        AnimatedMeshGradient()
          .mask(RoundedRectangle(cornerRadius: 16)
            .stroke(lineWidth: 16)
            .blur(radius: 8)
          )
          .overlay{
            RoundedRectangle(cornerRadius: 16)
              .stroke(.white, lineWidth: 3)
              .blur(radius: 2)
              .blendMode(.overlay)
          }
          .overlay{
            RoundedRectangle(cornerRadius: 16)
              .stroke(.white, lineWidth: 1)
              .blur(radius: 1)
              .blendMode(.overlay)
          }
      )
      .background(.black)
      .cornerRadius(16)
      .background(
        RoundedRectangle(cornerRadius: 16)
          .stroke(.black.opacity(0.5), lineWidth: 1)
      )
    }
}

#Preview {
    TextWidget()
}
