//
//  DiamondShape.swift
//  PrankMemo
//
//  Created by t&a on 2024/09/03.
//

import SwiftUI

struct DiamondShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.width
        let height = rect.height
        
        let centerX = rect.midX
        let centerY = rect.midY
        
        path.move(to: CGPoint(x: centerX, y: 0))
        path.addLine(to: CGPoint(x: width / 1.5, y: centerY / 1.5))
        path.addLine(to: CGPoint(x: width, y: centerY))
        path.addLine(to: CGPoint(x: width / 1.5, y: height / 1.5))
        path.addLine(to: CGPoint(x: centerX, y: height))
        path.addLine(to: CGPoint(x: centerX / 1.5, y: height / 1.5))
        path.addLine(to: CGPoint(x: 0, y: centerY))
        path.addLine(to: CGPoint(x: centerX / 1.5, y: centerY / 1.5))
        path.closeSubpath()
        
        
        return path
    }
}

struct AnimationDiamondView: View {
    public let position: CGPoint
    public let index: Int
    @State private var animate: Bool = false
    private let animationDuration: Double = 1.0
    
    private func startAnimation() {
        withAnimation(
            Animation.easeInOut(duration: animationDuration)
                .repeatForever(autoreverses: true)
                .delay(Double(index) * animationDuration / 5)
        ) {
            self.animate.toggle()
        }
    }
    
    var body: some View {
        DiamondShape()
            .fill(.themaYellow)
            .frame(width: 20, height: 20)
            .scaleEffect(animate ? 1.5 : 1.0)
            .opacity(animate ? 1.0 : 0.5)
            .position(position)
            .onAppear {
                startAnimation()
            }
    }
}

#Preview {
    DiamondShape()
        .fill(.themaYellow)
        .frame(width: 80, height: 80)
}
