//
//  TournamentController.swift
//  RealTimeStats
//
//  Created by Michael Flowers on 11/22/21.
//

import Foundation
struct Bearer: Codable {
    let token: String
}

class TournamentController {
    static let shared = TournamentController()
    var currentTournament: Tournament?
    var bearer = Bearer(token: "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI5NTA2MTdkNy0wN2JiLTQ1MDQtYTViYS03NzkyZjgwMGZkOTciLCJqdGkiOiI0N2U0OTg1Nzc3MWUxNDJmNWQ4YjQxOWFmOWNkYmYzM2EzY2RhOTJiYjhiODg5ODY3ZDZiNWQxNGMxZDlmYWZmODE2NTRhNjJkNTZiNDNiZSIsImlhdCI6MTYzODUzODExNi44OTc2MzQsIm5iZiI6MTYzODUzODExNi44OTc2MzgsImV4cCI6MTY3MDA3NDExNi44OTU1NjcsInN1YiI6IjMiLCJzY29wZXMiOltdfQ.WADo-Mv6WcO-H6L45mRnhUKTRCX519rgtLeGEu_b-dAS1NSLXpidXXNsHTAEAnmkL7KgemX6oMzEREnPYrDpR_qYc8F3HRzlm7mq-rSc3MkSfF4qKWy7D-DRYKpKotCn5jfL8yieKWsuW-RdkIy3-wtxxQPbZqWezC133bYVXrEV9bUz9ylIjPCw5XKyZ0sblbmfcEv7DcHNjYEyql0qMAvM4b_HtzOX2ar-SCF8hQgxFS4DJ5K95iVZfsDBhI_FKOqJpueNMjnrNd32kr-27V8RCOTcYau4wQP1Ejv-rcBQLQKn24YduCxlMih2-ta5qYxTlVnRgU90GcTajw4THXyy5mCkXePfttQXUqA4gLPEYuMSSvTUrlU4Frgjh9vjjHwlrAgVrZ8HR8rd3LfV1Pyk8ifmux3TeWxGckMYOmGXCrkGWnaGc2HwuG8LLBMW7cRgf1vJzfww0b6CEXl61RZ6KjJ9YPZmDtx-AP6Xxu302Uwru_uL9pESN_iSSfuryg4F0REoJVUsuh_hDdQBfVL0iBMksZn8VSG24e9QezknCBYF5qQ0g8KYn2rAX6R1JuPAEqnkWunrAFclYLNNJLJr4KE0MkiVg9EZ5gMuj5SOzQMsAdpONwlvmIX_65c98Rnx5YY8kGbdhaZeT5v0N0jxm8OfRaduUaWZjEuODWc")
    
    private let baseURL = URL(string: "https://documenter.getpostman.com/view/18558387/UVJfiuzH#9defa40d-71de-427c-876f-0ec1a2f03345")!

    
    func createTournament(withName name: String) {
        let tournament = Tournament(name: name)
        currentTournament = tournament
        print("tournament just created: \(String(describing: self.currentTournament))")
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

//MARK: - Networking
extension TournamentController {
    func postTournamentWith(name: String, completion: @escaping (Error?) -> Void) {
        //get url
        let url = self.baseURL.appendingPathComponent("tournaments")
        
        //create urlRequest
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
    
        //Get the bearer and add its value to the header/key. Per backend we only need this and not content-type
        request.addValue("Bearer \(bearer.token)", forHTTPHeaderField: "Authorization")
        
        //encode tournament name and then add it to the body to send to the server
        let je = JSONEncoder()
        do {
            let jsonData = try je.encode(name)
            request.httpBody = jsonData
        } catch {
            print("Error encoding tournament name to post to server: \(error.localizedDescription)")
            completion(error)
            return
        }
        
        //now that we have the request set up we can can run urlSession
        URLSession.shared.dataTask(with: request) { data , response , error  in
            if let response = response as? HTTPURLResponse {
                print("HTTPResponse: \(response.statusCode) in function: \(#function)")
            }
            
            if let error = error {
                print("""
                   Error: \(error.localizedDescription) on line \(#line)
                   in function: \(#function)\n Technical error: \(error)
                   """)
                completion(error)
            }
            
            guard let data = data else {
                print("Error on line: \(#line) in function: \(#function)")
                completion(NSError())
                return
            }
            
            //decode data into
        }
    }
}
