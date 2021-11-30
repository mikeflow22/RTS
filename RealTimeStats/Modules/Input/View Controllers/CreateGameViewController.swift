//
//  CreateGameViewController.swift
//  RealTimeStats
//
//  Created by Michael Flowers on 11/22/21.
//

import UIKit

class CreateGameViewController: UIViewController {
    var tc: TournamentController? {
        didSet {
            print("tc was set in: createGameVC")
        }
    }
    var awayTeam: Team?
    var homeTeam: Team?
    
    var game: Game? {
        didSet {
            print("game was set")
        }
    }
    let mockTeams: [Team] = [
        Team(name: "Awesome Team", grade: 3, gender: "Boys"),
        Team(name: "Sucky Team", grade: 3, gender: "Boys"),
        Team(name: "Cool Team", grade: 3, gender: "Boys"),
        Team(name: "Flamers Team", grade: 3, gender: "Boys"),
        Team(name: "Runners Team", grade: 3, gender: "Boys"),
    ]
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var saveButtonAttributes: UIBarButtonItem!
    @IBOutlet weak var playGameAttributes: UIBarButtonItem!
    
    @IBOutlet weak var awayTeamNameLabel: UILabel!
    @IBOutlet weak var awayTeamGradeLabel: UILabel!
    @IBOutlet weak var awayTeamGenderLabel: UILabel!
    @IBOutlet weak var clearAwayTeamAttributes: UIButton!
    
    
    @IBOutlet weak var homeTeamNameLabel: UILabel!
    @IBOutlet weak var homeTeamGradeLabel: UILabel!
    @IBOutlet weak var homeTeamGenderLabel: UILabel!
    @IBOutlet weak var clearHomeTeamAttributes: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "FindTeamTableViewCell", bundle: nil), forCellReuseIdentifier: "FindTeamCell")
        clearLabels()
        saveButtonAttributes.isEnabled = false
        playGameAttributes.isEnabled = false
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func playGameButtonPressed(_ sender: UIBarButtonItem) {
        createGame()
        //segue
        performSegue(withIdentifier: "toMainStoryboard", sender: nil)
        
    }
    
    @IBAction func clearAwayTeamButtonPressed(_ sender: UIButton) {
        awayTeamNameLabel.text = nil
        awayTeamGradeLabel.text = nil
        awayTeamGenderLabel.text = nil
        clearAwayTeamAttributes.isHidden = true
        playGameAttributes.isEnabled = false
        saveButtonAttributes.isEnabled = false
        self.awayTeam = nil
    }
    
    @IBAction func clearHomeTeamButtonPressed(_ sender: UIButton) {
        homeTeamNameLabel.text = nil
        homeTeamGradeLabel.text = nil
        homeTeamGenderLabel.text = nil
        clearHomeTeamAttributes.isHidden = true
        playGameAttributes.isEnabled = false
        saveButtonAttributes.isEnabled = false
        self.homeTeam = nil
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        createGame()
        //alert pops up that says saved
        //clears labels so user can create more games
    }
    
    //clear labels for viewDidLoad
    private func clearLabels() {
        awayTeamNameLabel.text = nil
        awayTeamGradeLabel.text = nil
        awayTeamGenderLabel.text = nil
        clearAwayTeamAttributes.isHidden = true
        
        homeTeamNameLabel.text = nil
        homeTeamGradeLabel.text = nil
        homeTeamGenderLabel.text = nil
        clearHomeTeamAttributes.isHidden = true
    }
    
    private func createGame() {
        guard let tc = tc, let awayTeam = awayTeam, let homeTeam = homeTeam else {
            print("no tc to save game")
            return
        }
        game = Game(homeTeam: homeTeam, awayTeam: awayTeam)
        tc.creatGame(withAwayTeam: awayTeam, andHomeTeam: homeTeam)
    }
    
    

     // MARK: - Navigation
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == "toMainStoryboard" {
             guard let destinationVC = segue.destination as? MainVC, let tc = self.tc, let game = self.game else {
                 print("error seguing to MainVC in CreateGameVC file")
                 return
             }
             destinationVC.tc = tc
             destinationVC.game = game
         }
     }
     
}

extension CreateGameViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let tc = tc, let teams = tc.currentTournament?.teams else {
            return 1
        }
        return teams.count
//                return mockTeams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FindTeamCell", for: indexPath) as! FindTeamTableViewCell
//
//                let team = mockTeams[indexPath.row]
//                cell.teamNameLabel.text = team.name
//                cell.teamGradeLabel.text = "\(team.grade)"
//                cell.teamGenderLabel.text = team.gender
        
        guard let tc = tc, let teams = tc.currentTournament?.teams else {
            return UITableViewCell()
        }

        let team = teams[indexPath.row]
        cell.teamNameLabel.text = team.name
        cell.teamGradeLabel.text = "\(team.grade)"
        cell.teamGenderLabel.text = team.gender
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let tc = tc, let teams = tc.currentTournament?.teams else {
            return
        }
        let team = teams[indexPath.row]
        if awayTeamNameLabel.text == nil && awayTeamGradeLabel.text == nil && awayTeamGenderLabel.text == nil {
            awayTeamNameLabel.text = team.name
            awayTeamGradeLabel.text = "\(team.grade)"
            awayTeamGenderLabel.text = team.gender
            clearAwayTeamAttributes.isHidden = false
            self.awayTeam = team
        } else if homeTeamNameLabel.text == nil && homeTeamGradeLabel.text == nil && homeTeamGenderLabel.text == nil {
            homeTeamNameLabel.text = team.name
            homeTeamGradeLabel.text = "\(team.grade)"
            homeTeamGenderLabel.text = team.gender
            clearHomeTeamAttributes.isHidden = false
            self.homeTeam = team
        }
        //check if both away and home teams are set
        if awayTeam != nil && homeTeam != nil {
            playGameAttributes.isEnabled = true
            saveButtonAttributes.isEnabled = true
        }
    }
}
