//
//  Player.swift
//  RealTimeStats
//
//  Created by Michael Flowers on 10/23/21.
//

import Foundation

class Player {
    let name: String
    let number: Int
//    let position: String
    let team: String
    var offFoul: Int
    var deffFoul: Int
    var totalFouls: Int {
        return offFoul + deffFoul
    }
    var oRebound: Int
    var dRebound: Int
    var totalRebound: Int {
        return oRebound + dRebound
    }
    var madeFreethrow: Int
    var missedFreethrow: Int
    var block: Int
    var assist: Int
    var steal: Int
    var turnover: Int
    var jumpBallForced: Int
   
    var points: Int {
        return ((fgm2 * 2) + (fgm3 * 3) + madeFreethrow)
    }
    var fga2: Int
    var fgm2: Int
    var fga3: Int
    var fgm3: Int
    var shootingPercentage2fg: Double
    var plays: [Play]
    var shots: [Shot]
    
    init(name: String, number: Int /*,position: String*/) {
        self.name = name
        self.number = number
        //        self.position = ""
        self.team = ""
        self.offFoul = 0
        self.deffFoul = 0
        self.oRebound = 0
        self.dRebound = 0
        self.madeFreethrow = 0
        self.missedFreethrow = 0
        self.block = 0
        self.assist = 0
        self.steal = 0
        self.turnover = 0
        self.jumpBallForced = 0
        self.fga2 = 0
        self.fgm2 = 0
        self.fga3 = 0
        self.fgm3 = 0
        self.shootingPercentage2fg = 0.0
        self.plays = []
        self.shots = []
    }
    
    static var players: [Player] =
    [
    Player(name: "Michael", number: 25),
    Player(name: "Jonte", number: 24),
    Player(name: "Jason", number: 23),
    Player(name: "Jay Jay", number: 22),
    Player(name: "Marques", number: 21)
    ]
}
