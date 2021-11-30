//
//  MockTeams.swift
//  RealTimeStats
//
//  Created by Michael Flowers on 11/25/21.
//

import Foundation


struct MockTeams {
    static let awayTeam = Team(name: "B Team", grade: 8, gender: "Boys", players: MockAwayTeamPlayers.players)
    
    static let homeTeam = Team(name: "A Team", grade: 8, gender: "Boys", players: MockHomeTeamPlayers.players)
    
    static let awesomeTeam = Team(name: "Awesome Team", grade: 8, gender: "Boys", players: MockAwayTeamPlayers.players)
    
    static let suckyTeam = Team(name: "Sucky Team", grade: 8, gender: "Boys", players: MockHomeTeamPlayers.players)
    
    static let coolTeam = Team(name: "Cool Team", grade: 8, gender: "Boys", players: MockAwayTeamPlayers.players)
    
    static let flamersTeam = Team(name: "Flamers Team", grade: 8, gender: "Boys", players: MockHomeTeamPlayers.players)
    
    static let runnersTeam = Team(name: "Runners Team", grade: 8, gender: "Boys", players: MockAwayTeamPlayers.players)
    
    static let teams: [Team] =

    [awayTeam, homeTeam, awesomeTeam, suckyTeam, coolTeam, flamersTeam, runnersTeam]
    
}


struct MockAwayTeamPlayers {
    static var players: [Player] {
        let player1 = Player(name: "Jake K.", number: 1)
        let player2 = Player(name: "Chad B.", number: 2)
        let player3 = Player(name: "Kevin H.", number: 11)
        let player4 = Player(name: "Samual L.", number: 13)
        let player5 = Player(name: "Sameer E.", number: 15)
        let player6 = Player(name: "Dillan J.", number: 51)
        let player7 = Player(name: "Kyle N.", number: 5)
        let player8 = Player(name: "Casey A.", number: 32)
        let player9 = Player(name: "Aaron L.", number: 43)
        let player10 = Player(name: "Filip F.", number: 34)
        let player11 = Player(name: "Matt G.", number: 24)
        let player12 = Player(name: "Gary E.", number: 25)
        let player13 = Player(name: "Sheldon C.", number: 55)
        let player14 = Player(name: "Nadir F.", number: 0)
        let player15 = Player(name: "Ashton P.", number: 3)
        
        return [
            player1,
            player2,
            player3,
            player4,
            player5,
            player6,
            player7,
            player8,
            player9,
            player10,
            player11,
            player12,
            player13,
            player14,
            player15
        ]
    }
}

struct MockHomeTeamPlayers {
    static var players: [Player] {
        let player1 = Player(name: "Michael F.", number: 25)
        let player2 = Player(name: "Jonte F.", number: 24)
        let player3 = Player(name: "Jason F.", number: 23)
        let player4 = Player(name: "Jay Jay F.", number: 22)
        let player5 = Player(name: "Marques F.", number: 21)
        let player6 = Player(name: "Brett D.", number: 15)
        let player7 = Player(name: "Curt R.", number: 5)
        let player8 = Player(name: "Marty M.", number: 55)
        let player9 = Player(name: "Jason H.", number: 32)
        let player10 = Player(name: "Andy K.", number: 20)
        let player11 = Player(name: "Cris Q.", number: 3)
        let player12 = Player(name: "Preston F.", number: 35)
        let player13 = Player(name: "Phil K.F.", number: 2)
        let player14 = Player(name: "Quentin F.", number: 4)
        let player15 = Player(name: "MJ F.", number: 1)
        
        return [
            player1,
            player2,
            player3,
            player4,
            player5,
            player6,
            player7,
            player8,
            player9,
            player10,
            player11,
            player12,
            player13,
            player14,
            player15
        ]
    }
}

struct MockGame {
    static var games: [Game] {
        return [Game(homeTeam: MockTeams.homeTeam, awayTeam: MockTeams.awayTeam)]
    }
}
