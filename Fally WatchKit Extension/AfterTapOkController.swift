//
//  AfterTapOkController.swift
//  Fally
//
//  Created by Parinthorn Saithong on 12/8/2016.
//  Copyright © 2016 Parinthorn Saithong. All rights reserved.
//

import WatchKit
import Foundation


class AfterTapOkController: WKInterfaceController {

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        setTitle("Ok")
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
