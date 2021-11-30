//
//  HomeTeamPlayerVC.swift
//  RealTimeStats
//
//  Created by Michael Flowers on 10/24/21.
//

import UIKit

struct ReuiseIdentifier {
    static let homeTeam = "HomeTeamPlayerCell"
}

protocol HomeTeamPlayerDelegate: AnyObject {
    func sendPlayerToMainVC(_ player: Player)
}

class HomeTeamPlayerVC: UIViewController {
//    var mainVC: ViewController? {
//        didSet { print("MainVC was set")
//        }
//    }
    
    var tempRebound = 0
    var tempStat: Stats? {
        didSet {
            print("temp stat was set in the didSelect tableView method")
        }
    }
  
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PlayerTableViewCell.returnNib(), forCellReuseIdentifier: PlayerTableViewCell.reuseIdentifier)
        //print("checking mainVC.reboundDelegate before trying to set: \(String(describing: mainVC?.reboundDelegate))")
        //mainVC?.reboundDelegate = self
        //print("checking mainVC.reboundDelegate after setting it: \(String(describing: mainVC?.reboundDelegate))")
    }
}

extension HomeTeamPlayerVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Player.players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PlayerTableViewCell.reuseIdentifier, for: indexPath) as! PlayerTableViewCell
        let player = Player.players[indexPath.row]
        cell.setupPlayerCell(withPlayerViewModel: PlayerViewModel(player: player))
        return cell
    }
}


extension HomeTeamPlayerVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let player = Player.players[indexPath.row]
//        player.points += 12
//        player.rebound += tempRebound
        print("player: \(player.name) should have \(player.points) points and \(player.totalRebound) rebounds")
        tempRebound = 0
//        if let unwrappedStat = tempStat {
//            mainVC?.playToSend = PlayByPlay(quarter: .q4, half: .h2, player: player.name, stat: unwrappedStat)
//            tempStat = nil
//            print("temp stat should be nil: \(String(describing: tempStat))")
//        } else {
//            print("temp stat is nil")
//        }
        tableView.reloadData()
    }
}

extension HomeTeamPlayerVC: ReboundButtonViewDelegate {
    func addStat(statString: String) {
        guard let stat = Stats(rawValue: statString) else {
            print("not a stat string that works")
            return
        }
        tempStat = stat
    }
    
    func addRebound() {
        print("addRebound function triggered")
        tempRebound += 1
    }
}
