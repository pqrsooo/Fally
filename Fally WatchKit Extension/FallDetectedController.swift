//
//  InterfaceController.swift
//  Fally WatchKit Extension
//
//  Created by Parinthorn Saithong on 12/7/2016.
//  Copyright © 2016 Parinthorn Saithong. All rights reserved.
//

import WatchKit
import Foundation


class FallDetectedController: WKInterfaceController {
    
    @IBOutlet var counterLabel: WKInterfaceLabel!
    @IBOutlet var counterGroup: WKInterfaceGroup!
    @IBOutlet var headerLabel: WKInterfaceLabel!
    @IBOutlet var fallIcon: WKInterfaceImage!
    
    let TIMER_MAX_BOUND = 30
    var timerCounter: Int
    var timer = Timer()

    override init() {
        timerCounter = TIMER_MAX_BOUND
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        setTitle("Fally")
        
        // Decorate headerLabel
        let firstLine = "Are you alright?\n"
        let firstLineAttr = [NSFontAttributeName: UIFont.systemFont(ofSize: 16), NSForegroundColorAttributeName: UIColor.white]
        let firstLineAttrText = NSMutableAttributedString(string: firstLine, attributes: firstLineAttr)
        
        let secondLine = "Notify for help in"
        let secondLineAttr = [NSFontAttributeName: UIFont.systemFont(ofSize: 13
            ), NSForegroundColorAttributeName: UIColor.gray]
        let secondLineAttrText = NSMutableAttributedString(string: secondLine, attributes: secondLineAttr)
        
        firstLineAttrText.append(secondLineAttrText)
        headerLabel.setAttributedText(firstLineAttrText)
        
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
        
        // Init counter label and timer ring
        let timeString = String(format: "00:%02d", timerCounter)
        counterLabel.setText("\(timeString)")
        counterGroup.setBackgroundImageNamed("timer-ring\(timerCounter)")
    }
    
    func updateTimer() {
        timerCounter -= 1
        
        if(timerCounter == 0) {
            timer.invalidate()
            // TODO: Segue to notifying view
        }
        
        // Update counter label and timer ring
        let timeString = String(format: "00:%02d", timerCounter)
        counterLabel.setText("\(timeString)")
        counterGroup.setBackgroundImageNamed("timer-ring\(timerCounter)")
        
        animateFallIcon()
    }
    
    func animateFallIcon() {
        animate(withDuration: 0.3) {
            self.fallIcon.setAlpha(0.4)
        }
        delay(0.3) {
            self.animate(withDuration: 0.7) {
                self.fallIcon.setAlpha(1.0)
            }
        }
    }
    
    func delay(_ delay: Double, closure: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            closure()
        }
    }

}
