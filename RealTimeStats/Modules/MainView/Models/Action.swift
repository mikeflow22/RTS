//
//  PlayByPlay.swift
//  RealTimeStats
//
//  Created by Michael Flowers on 10/26/21.
//

import UIKit
enum Quarter: String {
    case q1 = "Q1"
    case q2 = "Q2"
    case q3 = "Q3"
    case q4 = "Q4"
}

enum Halves: String {
    case h1 = "H1"
    case h2 = "H2"
}

enum Stats: String {
    case offFoul = "Called for a charging foul"
    case defFoul = "Committed defensive foul"
    case oRebound = "Grabbed an O-Rebound"
    case dRebound = "Grabbed a D-Rebound"
    case madeFreethrow = "Made a freethrow"
    case missedFreethrow = "Missed a freethrow"
    case block = "Blocked a shot"
    case assist = "Got an assist"
    case steal = "Stole the ball"
    case turnover = "Committed a turnover"
    case jumpBall = "Forced a jumpball"
    case madeA2pt = "Scored 2 points"
    case missedA2pt = "Missed a 2pt shot"
    case madeA3pt = "Scored 3 points"
    case missedA3pt = "Missed a 3pt shot"
//    case shot = "Shot"
//    case points = "Points"
}
struct Shot {
    let location: CGPoint //store percentage of location based on screen size/rotation
    let stats: Stats
    let success: Bool
//    let type: ShotType
}
enum ShotType: Int {
    case twoPoints = 2
    case threePoints = 3
}

class Action {
    let breaks: Breaks
    let time: Double
    let stat: Stats
    let shot: Shot?
    
    init(breaks: Breaks, time: Double, stat: Stats, shot: Shot? = nil) {
        self.breaks = breaks
        self.time = time
        self.stat = stat
        self.shot = shot
    }
}

struct Play {
    let player: Player
    let action: Action
}
