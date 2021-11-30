//
//  SearchForTournamentViewController.swift
//  RealTimeStats
//
//  Created by Michael Flowers on 11/22/21.
//

import UIKit

class SearchForTournamentViewController: UIViewController {
    var tc: TournamentController? {
        didSet {
            print("tournament controller set in \(#file)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        nextButtonAttributes.isEnabled = false
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var nextButtonAttributes: UIBarButtonItem!
    
    @IBAction func nextButtonPressed(_ sender: UIBarButtonItem) {
        
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toFindTeamVC" {
            if let destinationVC = segue.destination as? CreateViewController{
                destinationVC.tc = tc
            }
        }
    }
}

extension SearchForTournamentViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("searchbar button was clicked")
        guard let tournamentName = searchBar.text, !tournamentName.isEmpty else {
            print("searchbar text is empty")
            return
        }
        guard let tc = self.tc else {
            print("no tc in searchbar")
            return
        }
        
        if tc.currentTournament?.name == tournamentName {
            print("we should segue to another scene")
            nextButtonAttributes.isEnabled = true
        }
    }
}
