//
//  CircularProgresView.swift
//  probablyareminder
//
//  Created by Antonio Lahoz on 07/03/23.
//

import SwiftUI

struct CircularProgresView: View {
    var timer = Timer
        .publish(every: 0.1, on: .main, in: .common)
        .autoconnect()
    @State var progress = 0.0
    @State var isPlaying = false
    let duration : Double
    
    var body: some View {
        VStack{
            CircularProgress(progress: progress,duration: duration)
                .frame(width: 80,height: 80)
            Button("Enable"){
                self.isPlaying.toggle()
            }
        }.onReceive(timer){ time in
            if isPlaying{
                progress = progress + 0.1
            } else {
                progress = 0.0
            }
        }
    }
}

struct CircularProgress: View{
    let progress : Double
    let duration : Double
    
    var body: some View{
        var proportion = (progress)/duration
        ZStack{
            Circle()
                .trim(from: 0,to: CGFloat(proportion))
                .stroke(
                    Color(.red),
                    style: StrokeStyle(
                        lineWidth: 8,
                        lineCap: .round)
                )
                .animation(.easeOut, value: progress)
                .animation(.easeIn, value: progress)
                .rotationEffect(Angle(degrees: 270))
        }
    }
}

struct CircularProgresView_Previews: PreviewProvider {
    static var previews: some View {
        CircularProgresView(duration: 10.0)
    }
}
