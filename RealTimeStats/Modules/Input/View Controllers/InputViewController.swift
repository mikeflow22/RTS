//
//  InputViewController.swift
//  RealTimeStats
//
//  Created by Michael Flowers on 11/22/21.
//

import UIKit

class InputViewController: UIViewController {
    let tc = TournamentController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func createTournamentButtonWasPressed(_ sender: UIButton) {
        print("createTournamentButtonWasPressed")
        createTournamentAlert()
    }
    
    @IBAction func joinTournamentButtonWasPressed(_ sender: UIButton) {
    }
    
    func createTournamentAlert() {
        let alert = UIAlertController(title: "Create Tournament", message: "Please enter the name of the tournament", preferredStyle: .alert)
        var myTextField: UITextField?
        
        alert.addTextField { textField in
            myTextField = textField
        }
        myTextField?.text = "jag"
        
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            guard let tournamentName = myTextField?.text, !tournamentName.isEmpty else {
                print("no text")
                self.createTournamentAlert()
                return
            }
            print("this was written in the textfield: \(tournamentName)")
           
            self.tc.createTournament(withName: tournamentName)
            self.performSegue(withIdentifier: "ToCreateRuleVC", sender: nil)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
        
    }
    
   
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToCreateRuleVC" {
            if let destinationVC = segue.destination as? CreateRulesViewController {
                destinationVC.tc = tc
            }
        }
        if segue.identifier == "toSearchForTournamentVC" {
            if let destinationVC = segue.destination as? SearchForTournamentViewController {
                destinationVC.tc = tc
            }
        }
    }


}
