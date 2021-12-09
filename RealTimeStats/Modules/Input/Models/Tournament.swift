//
//  Tournament.swift
//  RealTimeStats
//
//  Created by Michael Flowers on 11/22/21.
//

import Foundation

class Tournament: Equatable, Codable {
    static func == (lhs: Tournament, rhs: Tournament) -> Bool {
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

