//
//  ContentView.swift
//  Timer
//
//  Created by Antonio Lahoz on 02/03/23.
//

import SwiftUI


class Cronometro: ObservableObject {
    
    
   
    @Published var hours: Int = 0
    @Published var minutes: Int = 0
    @Published var seconds: Int = 0
    
//    @State var timerIsPaused: Bool = true
    var timer: Timer? = nil
    
    
    
    func startTimer() -> String{
        
        // 1. Make a new timer
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ tempTimer in
            // 2. Check time to add to H:M:S
            if self.seconds == 59 {
                self.seconds = 0
                
                if self.minutes == 59 {
                    self.minutes = 0
                    self.hours = self.hours + 1
                } else {
                    
                    self.minutes = self.minutes + 1
                }
            } else {
                
                self.seconds = self.seconds + 1
            }
        }
        
//        var timerView = "\(hours):\(minutes):\(seconds)"
        
        return "\(hours):\(minutes):\(seconds)"
    }
    
    
    func restartTimer(){
        hours = 0
        minutes = 0
        seconds = 0
    }
    
        
}
