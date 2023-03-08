//
//  CircularProgressBar.swift
//  LT_ListOfSuperHeroes
//
//  Created by GaetanoMiranda on 02/03/23.
import SwiftUI


func calculateProgress(lastTimeDone: Date, frequency: Int) -> Float {
    
    let totalSeconds = Double(frequency*86400)
    let passedSeconds = Date.now.distance(to: lastTimeDone)
    let progress = passedSeconds/totalSeconds
    return abs(Float(progress))
}

struct CircularProgressBar: View {
    
    @EnvironmentObject var snakeColors: SnakeColors
    var lastTimeDone: Date
    var frequency: Int
    var timeleft: String {
        get {
            let time = timeLeft(lastTimeDone: lastTimeDone, frequency: frequency)
            return time
        }
    }
    
    var progress: Float {
        get {
            calculateProgress(lastTimeDone: lastTimeDone+86400, frequency: frequency)
        }
    }
    
    
    
    var body: some View {
        
        VStack {
            GeometryReader { geo in
                ZStack(alignment: .center) {
                    Circle()
                        .stroke(lineWidth: 9.0)
                        .opacity(0.13)

                    
                    Circle()
                        .stroke(Color(.white), lineWidth: 10)
                        .opacity(1)
                        .blur(radius: 3)
          
                       
                       
                    
                    Circle()
                       // .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                        .trim(from: 0.0, to: CGFloat(min(self.progress, 313/360)))
                        .stroke(AngularGradient(gradient: Gradient(colors: snakeColors.selectedColors), center: .center, startAngle: .degrees(-6), endAngle: .degrees(354)), style: StrokeStyle(lineWidth: 10, lineCap: .round))
                      //  .stroke(AngularGradient(gradient: Gradient(colors: [.green, .yellow, .red]), center: .center), lineWidth: 20)
                        //.foregroundColor(Color.red)
                        .rotationEffect(Angle(degrees: 270.0))
                        
                    VStack {
                        if progress < 1 {
                            Text("Next in")
                        }
                        
                        Text(timeleft)
                    }
                    .onTapGesture {
                        print(progress)
                    }
                    
                    //Text(String(format: "%.0f %%", min(self.progress, 1.0)*100.0))
                    ZStack {
                            Image("snake")
                            .font(.system(size:18))
                            
                            
                                //  .symbolRenderingMode(.palette)
                                //                           .foregroundStyle(
                                //                            AngularGradient(gradient: Gradient(colors: [.green, .yellow, .red]), center: UnitPoint(x: geo.size.width/2, y: 0.5))
                                //                           )
                            .offset(x: 11, y: -(geo.size.height/2))
                                    .rotationEffect(.degrees(min(Double(self.progress) * 360,313)))
                        
                        
                        if progress != 0.0 {
                            AngularGradient(gradient: Gradient(colors: snakeColors.selectedColors), center: .center, startAngle: .degrees(-90), endAngle: .degrees(255.5))
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
            .frame(width: 88, height: 88)
            .onTapGesture {
                print(progress)
            }
            
        
        }
        
    }
}

//
//struct CircularProgressBar_Previews: PreviewProvider {
//    static var previews: some View {
//        CircularProgressBar()
//    }
//}
