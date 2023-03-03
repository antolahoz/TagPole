//
//  timeLeft.swift
//  LT_ListOfSuperHeroes
//
//  Created by GaetanoMiranda on 26/02/23.
//

import Foundation


func timeLeftCalc(lastTimeDone: Date, frequency: Int) -> String {
    let dueDate = lastTimeDone + Double(86400*frequency)
    let seconds = Date.now.distance(to: dueDate)
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
