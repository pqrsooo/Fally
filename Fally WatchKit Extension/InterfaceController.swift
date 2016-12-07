//
//  InterfaceController.swift
//  Fally WatchKit Extension
//
//  Created by Parinthorn Saithong on 12/7/2016.
//  Copyright © 2016 Parinthorn Saithong. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    
    @IBOutlet var counterLabel: WKInterfaceLabel!
    
    var timerCounter = 30
    var timer = Timer()

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        setTitle("Fally")
        initTimer()
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func initTimer() {
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTimer), userInfo: nil, repeats: true);
        
        // Set init counter label
        let timeString = String(format: "00:%02d", timerCounter)
        counterLabel.setText("\(timeString)")
    }
    
    func updateTimer() {
        timerCounter -= 1
        
        // Update counter label
        let timeString = String(format: "00:%02d", timerCounter)
        counterLabel.setText("\(timeString)")
    }

}
