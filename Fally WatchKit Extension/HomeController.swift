//
//  HomeController.swift
//  Fally
//
//  Created by Parinthorn Saithong on 12/8/2016.
//  Copyright © 2016 Parinthorn Saithong. All rights reserved.
//

import WatchKit
import Foundation
import CoreLocation


class HomeController: WKInterfaceController, CLLocationManagerDelegate {
    
    @IBOutlet var profileImg: WKInterfaceImage!
    @IBOutlet var helloMsg: WKInterfaceLabel!
    @IBOutlet var locationString: WKInterfaceLabel!
    @IBOutlet var locationMap: WKInterfaceMap!
    
    var locationManager: CLLocationManager = CLLocationManager()
    var locationMapDetail: CLLocationCoordinate2D?

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        setTitle("Fally")
        
        // Decorate helloMsg
        let firstLine = "Hello\n"
        let firstLineAttr = [NSFontAttributeName: UIFont.systemFont(ofSize: 14), NSForegroundColorAttributeName: UIColor.white]
        let firstLineAttrText = NSMutableAttributedString(string: firstLine, attributes: firstLineAttr)
        
        let secondLine = "Christopher R."
        let secondLineAttr = [NSFontAttributeName: UIFont.systemFont(ofSize: 13
            ), NSForegroundColorAttributeName: UIColor.init(red: 234.0/255.0, green: 28.0/255.0, blue: 73.0/255.0, alpha: 1.0)]
        let secondLineAttrText = NSMutableAttributedString(string: secondLine, attributes: secondLineAttr)
        
        firstLineAttrText.append(secondLineAttrText)
        helloMsg.setAttributedText(firstLineAttrText)
        
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestLocation()
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let currentLocation = locations[0]
        let lat = currentLocation.coordinate.latitude
        let long = currentLocation.coordinate.longitude
        
        self.locationMapDetail = CLLocationCoordinate2DMake(lat, long)
        
        let span = MKCoordinateSpanMake(0.1, 0.1)
        
        let region = MKCoordinateRegionMake(self.locationMapDetail!, span)
        self.locationMap.setRegion(region)
        
        self.locationMap.addAnnotation(self.locationMapDetail!, with: .red)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
