//
//  DateTestsView.swift
//  probablyareminder
//
//  Created by GaetanoMiranda on 07/03/23.
//

import SwiftUI

func timeLeft(lastTimeDone: Date, frequency: Int) -> String {
    let dueDate = lastTimeDone + Double(86400*frequency)
    let seconds = Date.now.distance(to: dueDate)
    //let seconds = dueDate.distance(to: Date.now)
    
    
    if seconds < 0 {
        let timeleft = "Expired"
        return timeleft
    }
    
    if seconds < 60 {
        let secondsInt = Int(seconds)
        let timeLeft = "\(secondsInt) s"
        
        return timeLeft
    }
    if seconds < 3600 {
        var minutes = seconds/60
        minutes = minutes.rounded()
        let minutesInt = Int(minutes)
        let timeleft = "\(minutesInt) m"
        return timeleft
    }
    if seconds < 86400 {
        var hours = seconds/3600
        hours = hours.rounded()
        let hoursInt = Int(hours)
        let timeleft = "\(hoursInt) h"
        return timeleft
    }
    
    var days = seconds/86400
    days = days.rounded()
    let daysInt = Int(days)
    let timeleft = "\(daysInt) d"
    return timeleft
}


struct DateTestsView: View {
    
    @State private var now = Date.now
    private var secondDate: Date {
        get {
            let date = Date.now + Double(frequency*86400)
            return date
        }
    }
    @State private var lastTime = Date.now
    @State private var frequency = 1
    var timeleft: String {
        get {
           let time = timeLeft(lastTimeDone: lastTime, frequency: frequency)
            return time
        }
    }
    
    var body: some View {
        VStack {
        
            Text("ora sono le \(now.formatted())")
            Text("last time is \(lastTime.formatted())")
            Stepper(value: $frequency, in: 1...100) {
                Text("frequenza: \(frequency)")
            }
            DatePicker(selection: $lastTime, label: { Text("Last time") })
            Text("due date is \(secondDate.formatted())")
            Text("time left is \(timeleft)")
            
        }
        
    }
}

struct DateTestsView_Previews: PreviewProvider {
    static var previews: some View {
        DateTestsView()
    }
}
