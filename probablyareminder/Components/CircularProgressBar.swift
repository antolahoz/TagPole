//
//  CircularProgressBar.swift
//  LT_ListOfSuperHeroes
//
//  Created by GaetanoMiranda on 02/03/23.
//

import SwiftUI

struct CircularProgressBar: View {
    @State private var progress: Float = 0.8
    @EnvironmentObject var snakeColors: SnakeColors
    
    var body: some View {
        
        VStack {
            GeometryReader { geo in
                ZStack(alignment: .center) {
                    Circle()
                       .stroke(lineWidth: 3)
                       .opacity(0.1)
                       
                    
                    Circle()
                        .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                        .stroke(AngularGradient(gradient: Gradient(colors: snakeColors.selectedColors), center: .center, startAngle: .degrees(-6), endAngle: .degrees(354)), style: StrokeStyle(lineWidth: 5, lineCap: .round))
                      //  .stroke(AngularGradient(gradient: Gradient(colors: [.green, .yellow, .red]), center: .center), lineWidth: 20)
                        //.foregroundColor(Color.red)
                        .rotationEffect(Angle(degrees: 270.0))
                        
                        
                    
                    Text(String(format: "%.0f %%", min(self.progress, 1.0)*100.0))
                    ZStack {
                            Image("snake")
                            .font(.system(size:5))
                            
                            
                                //  .symbolRenderingMode(.palette)
                                //                           .foregroundStyle(
                                //                            AngularGradient(gradient: Gradient(colors: [.green, .yellow, .red]), center: UnitPoint(x: geo.size.width/2, y: 0.5))
                                //                           )
                            .offset(y: -(geo.size.height/2))
                                    .rotationEffect(.degrees(Double(self.progress) * 360))
                        
                        
                        if progress != 0.0 {
                            AngularGradient(gradient: Gradient(colors: snakeColors.selectedColors), center: .center, startAngle: .degrees(-90), endAngle: .degrees(270))
                                .blendMode(.sourceAtop)
                            .padding(-30)
                        } else {
                            Color(.systemGray5)
                                .blendMode(.sourceAtop)
                                .padding(-30)
                        }
                    }.compositingGroup()
                        
                }
                
            }
            .frame(width: 50, height: 50)
            
        
        }
        
    }
}


struct CircularProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        CircularProgressBar()
    }
}
