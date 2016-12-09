//
//  MotionManager.swift
//  Fally
//
//  Created by Parinthorn Saithong on 12/8/2016.
//  Copyright © 2016 Parinthorn Saithong. All rights reserved.
//

import Foundation
import CoreMotion
import WatchKit

/**
 `MotionManagerDelegate` exists to inform delegates of motion changes.
 These contexts can be used to enable application specific behavior.
 */
protocol MotionManagerDelegate: class {
    func didFallDetected(_ manager: MotionManager)
}

class MotionManager {
    // MARK: Properties
    
    let motionManager = CMMotionManager()
    let queue = OperationQueue()
    
    // var hmm = HiddenMarkovModel()
    
    let useMockData = true
    var timer = Timer()
    
    
    var aStreamReader: StreamReader?
    let bundle = Bundle.main
    let separator = ","
    var prevLine = ""
    var eof = false
    
    // MARK: Application Specific Constants
    
    // The app is using 100hz data and the buffer is going to hold 1s worth of data.
    let sampleInterval = 1.0 / 100
    var inc = 0;
    
    weak var delegate: MotionManagerDelegate?
    
    // MARK: Initialization
    
    init() {
        // Serial queue for sample handling and calculations.
        queue.maxConcurrentOperationCount = 1
        queue.name = "MotionManagerQueue"
        HiddenMarkovModel.hmm.initializeValue()
        
        let fileName = getEnvironmentVar("input")
        let path = self.bundle.path(forResource: fileName, ofType: "txt")
        aStreamReader = StreamReader(path: path!);
    }
    
    // MARK: Motion Manager
    
    func startUpdates() {
        if !motionManager.isDeviceMotionAvailable {
            print("Device Motion is not available.")
            if useMockData {
                print("Use mock data instead.")
                timer.invalidate()
                timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.fetchMockAccelerationData), userInfo: nil, repeats: true);
            }
            return
        }
        
        motionManager.deviceMotionUpdateInterval = sampleInterval
        motionManager.startDeviceMotionUpdates(to: queue) { (deviceMotion: CMDeviceMotion?, error: Error?) in
            if error != nil {
                print("Encountered error: \(error!)")
            }
            
            if deviceMotion != nil {
                self.processDeviceMotion(deviceMotion!)
            }
        }
    }
    
    func stopUpdates() {
        if motionManager.isDeviceMotionAvailable {
            motionManager.stopDeviceMotionUpdates()
        } else {
            if useMockData {
                timer.invalidate()
            }
        }
    }
    
    // MARK: Motion Processing
    
    func processDeviceMotion(_ deviceMotion: CMDeviceMotion) {
        let userAcceleration = deviceMotion.userAcceleration
        
        hmmConnect(x: userAcceleration.x, y: userAcceleration.y, z: userAcceleration.z)
    }
    
    @objc func fetchMockAccelerationData() {
        if let line = aStreamReader?.nextLine() {
            prevLine = line
            let lineArr = line.components(separatedBy: separator)
            hmmConnect(x: (lineArr[2] as NSString).doubleValue, y: (lineArr[3] as NSString).doubleValue, z: (lineArr[4] as NSString).doubleValue)
        } else {
            timer.invalidate()
        }
    }
    
    func hmmConnect(x: Double, y: Double, z: Double) {
        print("\(x) \(y) \(z)")
        
        let acceleration = sqrt(x * x + y * y + z * z)
        HiddenMarkovModel.hmm.setAcceleration(acceleration: acceleration)
        let fall = HiddenMarkovModel.hmm.learnAndPredict()
        
        if fall {
            stopUpdates()
            fallDetected()
        }
    }
    
    // MARK: Data and Delegate Management
    
    func fallDetected() {
        delegate?.didFallDetected(self)
    }
    
    func getEnvironmentVar(_ name: String) -> String? {
        guard let rawValue = getenv(name) else { return nil }
        return String(utf8String: rawValue)
    }
}
