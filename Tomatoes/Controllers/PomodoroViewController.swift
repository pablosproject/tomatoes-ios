//
//  PomodoroViewController.swift
//  Tomatoes
//
//  Created by Paolo Tagliani on 29/10/16.
//  Copyright © 2016 Tomatoes. All rights reserved.
//

import UIKit
import PKHUD

class PomodoroViewController: UIViewController {
    @IBOutlet weak var todayLabel: UILabel!
    @IBOutlet weak var weekLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!

    private let networkService = ServiceProvider.sharedInstance.networkService
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if networkService.isLogged() {
            HUD.show(.progress)
            ServiceProvider.sharedInstance.networkService.user { user, error in
                HUD.hide()
                if let day = user?.counters?.day,
                    let week = user?.counters?.week,
                    let month = user?.counters?.month {
                    self.todayLabel.text = "\(day)"
                    self.weekLabel.text = "\(week)"
                    self.monthLabel.text = "\(month)"
                }
            }
        }
    }
}
