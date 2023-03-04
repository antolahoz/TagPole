//
//  ProgressBar.swift
//  notareminder
//
//  Created by GaetanoMiranda on 23/02/23.
//

import SwiftUI

struct ProgressBar: View {
    @Binding var value: Double
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle().frame(width: geometry.size.width , height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(Color(UIColor.systemTeal))
                
                Rectangle().frame(width: min(CGFloat(self.value)*geometry.size.width, geometry.size.width), height: geometry.size.height)
                    .foregroundColor(.white)
            }.cornerRadius(45.0)
        }
    }
}

struct BarView: View {
    @State var progressValue: Double
    
    var body: some View {
        VStack {
            ProgressBar(value: $progressValue).frame(height: 20)
            
            Button {
                
                progressValue = Double.random(in: 0...1)
            } label: {
                Text("premi")
            }
            
        }.padding()
    }
}


struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        BarView(progressValue: 0.67)
    }
}

