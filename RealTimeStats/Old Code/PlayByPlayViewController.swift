//
//  PlayByPlayViewController.swift
//  RealTimeStats
//
//  Created by Michael Flowers on 11/1/21.
//

import UIKit

class PlayByPlayViewController: UIViewController {

    var mainVC: MainViewController1? {
        didSet {
            print("MainVC variable was set in PlayByPlayViewController")
        }
    }

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PlayByPlayTableViewCell.returnNib(), forCellReuseIdentifier: PlayByPlayTableViewCell.reuseIdentifier)
        print("checking MainVC.playbyplayDelegate before trying to set: \(String(describing: mainVC?.playDelegate))")
        mainVC?.playDelegate = self
        print("checking MainVC.playbyplayDelegate after setting it. should be something: \(String(describing: mainVC?.playDelegate))")
    }
}

extension PlayByPlayViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PlayByPlayViewModel.plays.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PlayByPlayTableViewCell.reuseIdentifier, for: indexPath) as! PlayByPlayTableViewCell
//        let playByPlay = PlayByPlayViewModel.plays[indexPath.row]
//        cell.setupPlayForCell(playbyplay: playByPlay)
        
        return cell
    }
}

extension PlayByPlayViewController: UITableViewDelegate {
    
}

extension PlayByPlayViewController: PassPlayDelegate {
    func passPlay(_ play: Action) {
        print("pass play protocol delegate function was triggerd")
//        PlayByPlayViewModel.playByPlays.insert(play, at: 0)
        self.tableView.reloadData()
    }
}
