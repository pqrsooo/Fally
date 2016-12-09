//
//  HiddenMarkovModel.swift
//  Fally
//
//  Created by Parinthorn Saithong on 12/9/2016.
//  Copyright © 2016 Parinthorn Saithong. All rights reserved.
//

import Foundation



class HiddenMarkovModel {
    
    // Singleton
    static let hmm = HiddenMarkovModel()
    
    var initial = [Double]()
    var transition = [[Double]]()
    var emission = [[Double]]()

    let PENALTY = 0.1
    let UPDATE = 0.03
    let MIN_PROB_TRANSITION = 0.01
    
    var presentState: Int
    var acceleration: Double
    
    // MARK: Initialization
    
    init() {
        presentState = 0
        acceleration = 0.0
    }
    
    func initializeValue() {
        initial = [1, 0, 0, 0, 0, 0, 0]
        
        transition = [
            [0.992471406, 0.00101346460, 0.00231649052, 0.00260605183, 0.000434341972, 0.000723903287, 0.000434341972],
            [0.466666667, 0.133333333, 0.00000000, 0.266666667, 0.00000000, 0.0666666667, 0.0666666667],
            [0.435897436, 0.00000000, 0.410256410, 0.00000000, 0.153846154, 0.00000000, 0.00000000],
            [0.278688525, 0.0819672131, 0.0163934426, 0.540983607, 0.00000000, 0.0655737705, 0.0163934426],
            [0.136363636, 0.00000000, 0.272727273, 0.00000000, 0.590909091, 0.00000000, 0.00000000],
            [0.315789474, 0.0526315789, 0.00000000, 0.315789474, 0.00000000, 0.210526316, 0.105263158],
            [0.200000000, 0.00000000, 0.00000000, 0.00000000, 0.00000000, 0.500000000, 0.300000000]
        ]
        
        emission = [
            [1, 0],
            [0.44444444, 0.55555556],
            [0.23529412, 0.76470588],
            [0.2375, 0.7625],
            [0.15384615, 0.84615385],
            [0.26923077, 0.73076923],
            [0, 1]
        ]
    }
    
    func clearState() {
        presentState = 0
    }
    
    func setAcceleration(acceleration: Double) {
        self.acceleration = acceleration
    }
    
    func learnAndPredict() -> Bool {
        let nextState = getState(acceleration: acceleration)
        if presentState == 0 || nextState == 6 || transition[presentState][nextState] > MIN_PROB_TRANSITION {
            presentState = nextState
        }
        // Update probability table
        updateTransition(state: nextState)
        // Predict fall
        // if return true, all program will wait for user input
        // so we can get current state if wrong
        if emission[presentState][1] > emission[presentState][0] {
            return true
        }
        return false
    }
    
    func updateTransition(state: Int) {
        // New state weight 3%
        for i in 0..<7 {
            if state == i {
                transition[state][i] = (transition[state][i] + UPDATE) / (1 + UPDATE)
            } else {
                transition[state][i] = (transition[state][i]) / (1 + UPDATE)
            }
        }
    }
    
    func getState(acceleration: Double) -> Int {
        if acceleration < 0.34 {
            return 4
        } else if acceleration < 0.49 {
            return 2
        } else if acceleration < 1.685 {
            return 0
        } else if acceleration < 1.8 {
            return 1
        } else if acceleration < 2.6 {
            return 3
        } else if acceleration < 5 {
            return 5
        } else {
            return 6
        }
    }
    
    // If false positive
    func punish() {
        let state = getState(acceleration: acceleration)
        updateEmission(state: state)
        if state != presentState {
            updateTransitionPenalty(state: state)
        }
    }
    
    func updateEmission(state: Int) {
        // 10% penalty
        emission[state][0] = (emission[state][0] + PENALTY) / (1 + PENALTY)
        emission[state][1] = emission[state][1] / (1 + PENALTY)
    }
    
    func updateTransitionPenalty(state: Int) {
        // new state weight 10%
        for i in 0..<7 {
            if state == i {
                transition[state][i] = (transition[state][i] + PENALTY) / (1 + PENALTY)
            } else {
                transition[state][i] = (transition[state][i]) / (1 + PENALTY)
            }
        }
    }
}
