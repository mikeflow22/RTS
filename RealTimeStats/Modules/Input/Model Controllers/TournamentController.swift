//
//  TournamentController.swift
//  RealTimeStats
//
//  Created by Michael Flowers on 11/22/21.
//

import Foundation

class TournamentController {
    static let shared = TournamentController()
    var tournaments = [Tournament]()
    var currentTournament: Tournament?
    
    func createTournament(withName name: String) {
        let tournament = Tournament(name: name)
        currentTournament = tournament
        tournaments.append(tournament)
        print("tournament count: \(self.tournaments.count)")
    }
    
    func addRulesTo(_ rule: Rule) {
        guard let currentTournament = currentTournament else {
            return
        }
        
        currentTournament.rule = rule
        print("here are the rules to the tournament: \(String(describing: currentTournament.rule))")

    }
    
    func addTeam(_ team: Team) {
        guard let currentTournament = currentTournament else {
            print("no current tournament: \(#fileID)")
            return
        }
        currentTournament.teams.append(team)
        print("these are how many teams we have in this tournament: \(currentTournament.name) with \(currentTournament.teams.count) teams")
        for team in currentTournament.teams {
            print("these are the names of the teams in this tournament: \(team.name)")
        }
    }
    
    func creatGame(withAwayTeam away: Team, andHomeTeam home: Team) {
        guard let currentTournament = currentTournament else {
            return
        }
        let game = Game(homeTeam: home, awayTeam: away)
        currentTournament.games.append(game)
        print("there are these many games in this tournament: \(currentTournament.name) \(currentTournament.games.count) games")
    }
    
}
