//
//  AddPlayerViewController.swift
//  RealTimeStats
//
//  Created by Michael Flowers on 11/24/21.
//

import UIKit

class AddPlayerViewController: UIViewController {
    var tc: TournamentController? {
        didSet {
            print("tc was set in: addPlayerVC")
        }
    }
    var team: Team? {
        didSet {
            print("team was set in: addPlayerVC")
        }
    }
    var mockPlayers: [Player] = [
        Player(name: "Michael", number: 25),
        Player(name: "Jonte", number: 24),
        Player(name: "Jason", number: 23),
        Player(name: "Jay Jay", number: 22),
        Player(name: "Marques", number: 21)
    ]
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var saveButtonAttributes: UIButton!
    @IBOutlet weak var addPlayerAttributes: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.register(UINib(nibName: "AddPlayerTableViewCell", bundle: nil), forCellReuseIdentifier: "addPlayerCell")
        saveButtonAttributes.isEnabled = false
        if let team = self.team {
            print("navigation title should be changed in Add Player VC")
            self.title = "Add players to \(team.name)"
        }
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        guard let team = team else {
            print("Error trying to save team")
            return
        }
        for player in team.players {
            print("--- \(player.name) was added to \(team.name) team.")
        }
        
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers
        for aViewController in viewControllers {
            if aViewController is CreateViewController {
                self.navigationController!.popToViewController(aViewController, animated: true)
            }
        }
    }
    
    @IBAction func addPlayerButtonpressed(_ sender: UIBarButtonItem) {
        addPlayer()
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
extension AddPlayerViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return team?.players.count ?? 1
        return mockPlayers.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "addPlayerCell", for: indexPath) as! AddPlayerTableViewCell
        let player = mockPlayers[indexPath.row]
            cell.nameLabel.text = player.name
            cell.numberLabel.text = "\(player.number)"
        
//        if team?.players.count != 0 {
//            if let player = team?.players[indexPath.row] {
//                cell.nameLabel.text = player.name
//                cell.numberLabel.text = "\(player.number)"
//            }
//        } else {
//            cell.nameLabel.text = "Michael"
//            cell.numberLabel.text = "\(22)"
//        }
        
        // Configure the cell...
        
        return cell
    }
}

extension AddPlayerViewController {
    func addPlayer() {
        let alert = UIAlertController(title: "Add Player", message: "Please enter the following information", preferredStyle: .alert)
        var nameTF: UITextField!
        var numberTF: UITextField!
        //        var positionTF: UITextField!
        
        alert.addTextField { textField  in
            textField.placeholder = "Please Player name"
            textField.font = UIFont(name: "Montserrat", size: 45)
            textField.textAlignment = .center
            textField.text = "Michael"
            nameTF = textField
        }
        alert.addTextField { secondTextField in
            secondTextField.placeholder = "Please enter player's number"
            secondTextField.font = UIFont(name: "Montserrat", size: 45)
            secondTextField.textAlignment = .center
            secondTextField.text = "\(22)"
            numberTF = secondTextField
        }
        //        alert.addTextField { thirdTextField in
        //            thirdTextField.placeholder = "Please enter player's position"
        //            thirdTextField.font = UIFont(name: "Montserrat", size: 45)
        //            thirdTextField.textAlignment = .center
        //            positionTF = thirdTextField
        //        }
        
        
        let okAction = UIAlertAction(title: "OK", style: .default) { _  in
            guard let team = self.team else {
                print("no team set yet")
                return
            }
            
            guard let name = nameTF.text, !name.isEmpty else {
                return
            }
            guard let number = numberTF.convertToInt() else {
                return
            }
            //            guard let position = positionTF.text, !position.isEmpty else {
            //                return
            //            }
            
            let player = Player(name: name, number: number)
//            team.players.append(player)
//            self.tableView.reloadData()
//            if team.players.count >= 5 {
//                self.saveButtonAttributes.isEnabled = true
//            }
            self.mockPlayers.append(player)
            self.tableView.reloadData()
            if self.mockPlayers.count >= 5 {
                self.saveButtonAttributes.isEnabled = true
                team.players = self.mockPlayers
                print("--- \(self.mockPlayers.count) players were added to this team: \(team.name)")
            }
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
        
    }
}
