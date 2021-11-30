//
//  CreateTeamViewController.swift
//  RealTimeStats
//
//  Created by Michael Flowers on 11/22/21.
//

import UIKit

class CreateTeamViewController: UIViewController {
    var tournamentController = TournamentController()

    var tc: TournamentController? {
        didSet {
            print("tc set in CreateTeamVC")
        }
    }
    var teamToAddPlayersTo: Team? {
        didSet {
            print("team was created and set")
        }
    }
    
    @IBOutlet weak var teamNameTF: UITextField!
    @IBOutlet weak var teamGradeTF: UITextField!
    @IBOutlet weak var teamGenderTF: UITextField!
    @IBOutlet weak var addPlayerButtonAttributes: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
 
    @IBAction func addPlayerButtonPressed(_ sender: UIButton) {
        guard let name = teamNameTF.text, !name.isEmpty else {
            alert(title: "Error must fill all boxes", message: "Please enter Team name")
            return
        }
        guard let grade = teamGradeTF.convertToInt() else {
            alert(title: "Error must fill all boxes", message: "Please enter grade for Team")
            return
        }
        guard let gender = teamGenderTF.text, !gender.isEmpty else {
            alert(title: "Error must fill all boxes", message: "Please enter M or F")
            return
        }
        guard let tc = self.tc else {
            print("no tc in createTeamVC")
            return
        }
        let team = Team(name: name, grade: grade, gender: gender)
        tc.addTeam(team)
        self.teamToAddPlayersTo = team
        
    }
   
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAddPlayerVC" {
            if let destinationVC = segue.destination as? AddPlayerViewController {
                destinationVC.tc = self.tc
                destinationVC.team = self.teamToAddPlayersTo
            }
        }
    }
}

extension CreateTeamViewController {
    func alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}
