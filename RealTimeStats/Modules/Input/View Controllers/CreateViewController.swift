//
//  FindTeamViewController.swift
//  RealTimeStats
//
//  Created by Michael Flowers on 11/22/21.
//

import UIKit

class CreateViewController: UIViewController {
    var tc: TournamentController? {
        didSet {
            print("tc was set in FindTeamVC")
        }
    }
    var currentTeamsInTournament: [Team]? {
        didSet {
            print("new team created in FindTeamVC")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkHowManyTeamsAreInCurrentTournament()
    }

    override func viewWillAppear(_ animated: Bool) {
        checkHowManyTeamsAreInCurrentTournament()
    }
    
    func checkHowManyTeamsAreInCurrentTournament(){
//        let teams: [Team] = MockTeams.teams
//        if teams.count < 2 {
//            self.createGameAttributes.isEnabled = false
//        } else {
//            self.createGameAttributes.isEnabled = true
//        }
    
        guard let tc = tc, let currentTeamsInTournament = tc.currentTournament?.teams else {
            print("error trying to access tc in FindTeamVC")
            return
        }
        if currentTeamsInTournament.count < 2 {
            self.createGameAttributes.isEnabled = false
        } else {
            self.createGameAttributes.isEnabled = true
        }
    }
    
    @IBOutlet weak var createGameAttributes: UIButton!
    @IBAction func createTeamButtonPressed(_ sender: UIButton!) {
    }
    
    @IBAction func createGameButtonPressed(_ sender: UIButton!) {
    }
    
  
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCreateTeamVC" {
            if let destinationVC = segue.destination as? CreateTeamViewController {
                destinationVC.tc = self.tc
            }
        }
        if segue.identifier == "toCreateGameVC" {
            if let destinationVC = segue.destination as? CreateGameViewController {
                destinationVC.tc = self.tc
            }
        }
    }
}
