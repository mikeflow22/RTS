//
//  MockTournament.swift
//  RealTimeStats
//
//  Created by Michael Flowers on 11/25/21.
//

import Foundation
class MockTournament: Equatable {
    static func == (lhs: MockTournament, rhs: MockTournament) -> Bool {
        lhs.name == rhs.name
    }
    
    let name: String
    var rule: Rule?
    var teams: [Team]
    var games: [Game]
    
    init(name: String) {
        self.name = name
        self.rule = nil
        self.teams = []
        self.games = []
    }
}
let rules = Rule(halves: 2, timePerHalf: 15.00, foulLimit: 5, bonusLimit: 6, doubleBonusLimit: 10, timeouts: 3)
var teams: [Team] {
    return MockTeams.teams
}

