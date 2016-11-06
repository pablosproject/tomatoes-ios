//
//  PomodoroSession.swift
//  Tomatoes
//
//  Created by Paolo Tagliani on 06/11/16.
//  Copyright © 2016 Tomatoes. All rights reserved.
//

import Foundation
import UIKit

let pomodoroKey = "es.tomato.com.runningTomato"

class PomodoroSession {
    var pomodoroRunning:Bool {
        get {
            return UserDefaults.standard.object(forKey: pomodoroKey) != nil
        }
    }
    var pomodoroStartTime:NSDate? {
        get {
            return UserDefaults.standard.object(forKey: pomodoroKey) as? NSDate
        }
    }
    
    func startPomodoro() {
        UserDefaults.standard.set(NSDate(), forKey: pomodoroKey)
    }
}
