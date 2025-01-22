//
//  CardFor3D.swift
//  TrendSwiftApp
//
//  Created by 刘孝文 on 2025/1/22.
//

import SwiftUI
import CoreMotion


struct CardContentView: View {
    @State var motion: CMDeviceMotion? = nil
    let motionManager = CMMotionManager()
    let thresholdPitch: Double = 35 * .pi / 180
    let maxRotationAngle: Double = 20
    
    var rotation: (x:Double, y:Double){
      if let motion = motion{
        let pitchDegress = min(maxRotationAngle, motion.attitude.pitch > thresholdPitch ? ( motion.attitude.pitch - thresholdPitch ) * ( 100.0 / .pi ) : 0 )
        let rollDegress = min(maxRotationAngle, motion.attitude.roll * (100.0 / .pi) )
        return (x: -pitchDegress, y: rollDegress )
      }
      return (x:0, y:0)
    }
    
    var circleYOffset :CGFloat{
        if let motion = motion,motion.attitude.pitch > thresholdPitch{
            return CGFloat( (motion.attitude.pitch - thresholdPitch) * 600.0 / .pi )
        }
        return 0
    }
    
    var body: some View {
        ZStack{
            Image(.user).resizable().scaledToFill()
                .frame(width: 300, height: 300)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(color: .black.opacity(0.2), radius: 10, x:0, y:0 )
                .rotation3DEffect(
                    .init(degrees: rotation.x),
                    axis: (x:1.0, y:0.0, z:0.0)
                )
                .rotation3DEffect(
                    .init(degrees: rotation.y),
                    axis: (x:0.0, y:1.0, z:0.0)
                )
            Circle().frame(width: 70, height: 70)
                .foregroundStyle(.white.opacity(0.6))
                .blur(radius: 40)
                .offset(x: motion != nil ? CGFloat( motion!.gravity.x * 400 ) :0 , y: circleYOffset )
                .mask{
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: 300, height: 300)
                        .rotation3DEffect(
                            .init(degrees: rotation.x),
                            axis:  (x:1.0, y:0.0, z:0.0)
                        )
                        .rotation3DEffect(
                            .init(degrees: rotation.y),
                            axis:  (x:0.0, y:1.0, z:0.0)
                        )
                }
        }
        .onAppear{
            if motionManager .isDeviceMotionAvailable{
                self.motionManager.deviceMotionUpdateInterval = 1.0 / 60.0
                self.motionManager.startDeviceMotionUpdates(
                    to: OperationQueue.main){
                        ( data, error ) in
                        if let validDate = data{
                            self.motion = validDate
                        }
                    }
            }
        }
    }
}

struct CardFor3D: View {
    var body: some View{
        CardContentView()
    }
}

#Preview {
    CardFor3D()
}
