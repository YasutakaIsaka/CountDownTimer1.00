//
//  TimeCount.swift
//  CountDownTimer
//
//  Created by user on 2021/02/09.
//

import Foundation

class TimeCount: Void {
    let a = "Start"
    let b = "Stop"
    func timerAction(tSwitch: String, timer: Timer?) -> () {
        
        if tSwitch == a {
            if let nowTimer = timer  {
                if nowTimer.isValid == true {
                    return
                }
            }
            timer = Timer.sch
        }
    }
}
