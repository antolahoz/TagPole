//
//  CardShape.swift
//  probablyareminder
//
//  Created by GaetanoMiranda on 01/03/23.
//

import Foundation
import SwiftUI
struct CardShape: InsettableShape {
    
    var smallCornerRadius: Double
    var bigCornerRadius: Double
    var offset: Double
    var insetAmount = 0.0
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        
        path.move(to: CGPoint(x: smallCornerRadius+offset, y: 0.0))
        path.addLine(to: CGPoint(x: width-bigCornerRadius, y: 0.0))
        path.addArc(center: CGPoint(x: width-bigCornerRadius, y: bigCornerRadius), radius: bigCornerRadius, startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false)
        path.addLine(to: CGPoint(x: width, y: height-smallCornerRadius))
        path.addArc(center: CGPoint(x: width-smallCornerRadius, y: height-smallCornerRadius), radius: smallCornerRadius, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)
        path.addLine(to: CGPoint(x: smallCornerRadius, y: height))
        path.addArc(center: CGPoint(x: smallCornerRadius+offset, y: height-smallCornerRadius), radius: smallCornerRadius, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)
        path.addLine(to: CGPoint(x: offset, y: smallCornerRadius))
        path.addArc(center: CGPoint(x: smallCornerRadius+offset, y: smallCornerRadius), radius: smallCornerRadius, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)
        path.closeSubpath()
        
        
        return path
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self
        arc.insetAmount += amount
        return arc
    }
}
