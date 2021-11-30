//
//  Team.swift
//  RealTimeStats
//
//  Created by Michael Flowers on 11/5/21.
//

import Foundation

class Team: Equatable {
    static func == (lhs: Team, rhs: Team) -> Bool {
        lhs.name == rhs.name && lhs.grade == rhs.grade
    }
    
    let name: String
    let grade: Int
    let gender: String
    var players : [Player]
    let teamStat: TeamStat?
    var wins: Int
    var losses: Int
    var gamesPlayed: [Game]?
    init(name: String, grade: Int, gender: String) {
        self.name = name
        self.grade = grade
        self.gender = gender
        self.players = []
        self.teamStat = nil
        self.wins = 0
        self.losses = 0
        self.gamesPlayed = []
    }
     init(name: String, grade: Int, gender: String, players: [Player]){
        self.name = name
        self.grade = grade
        self.gender = gender
        self.players = players
         self.teamStat = nil
         self.wins = 0
         self.losses = 0
         self.gamesPlayed = []
    }
}
extension Team {
}

class Game {
    let homeTeam: Team
    let awayTeam: Team
    init(homeTeam: Team, awayTeam: Team) {
        self.homeTeam = homeTeam
        self.awayTeam = awayTeam
    }
}

class TeamStat {
//    var possessions: Int
//    var timeOuts: Int
//    var wins: Int
//    var losses: Int
//    var gamesPlayed: Int
//    var shootingBonus: Bool
//    var shootingDoubleBonus: Bool
//    var possessionArrow: Bool
////    let stat: Stats
//    init(possession)
}

