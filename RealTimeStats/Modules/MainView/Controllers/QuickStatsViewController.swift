//
//  GuestHostsVC.swift
//  RealTimeStats
//
//  Created by Debbi Chandel on 20/11/21.
//

import UIKit

class QuickStatsViewController: UIViewController {
    //MARK: - Properties
    var mainVC: MainVC? {
        didSet {
            print("passed the mainVC to QuickStatsVC for delegate pattern communication")
        }
    }
    var game: Game? {
        didSet {
            print("Game was set in quickStatsVC")
        }
    }
    
    var teamFromMainVC: Team? {
        didSet {
            guard teamFromMainVC != nil else {
                return
            }
            print("awayTeam set in QuickStatsVC")
//            self.tableView.reloadData()
        }
    }

    let identifier = "QuickStatsTVCell"
    
    ///
    /// OUTLETS
    ///
    /// Table View
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
            tableView.backgroundColor = UIColor.clear
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainVC?.passTeam = self
        mainVC?.reloadQStatsTableView = self
    }
}

//MARK:- TableView DataSource
extension QuickStatsViewController: UITableViewDataSource {
    
    /// Number Of Rows In Section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count: Int!
        
        if let team = teamFromMainVC {
            count = team.players.count
        }
        return count ?? 1
    }

    /// Cell For Row At indexPath
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        var cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! QuickStatsTVCell

        if let team = self.teamFromMainVC  {
            let player = team.players[indexPath.row]
            cell.playerNameLabel.text = player.name
            cell.pointsLabel.text = "\(player.points)"
            cell.reboundLabel.text = "\(player.totalRebound)"
            cell.assistLabel.text = "\(player.assist)"
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! QuickStatsTVCell
        }
        
        cell.backgroundColor = UIColor.clear
        cell.selectionStyle = .none
        
        /// GuestHosts Cell
//        QuickStatsCell(cell: cell, indexPath: indexPath)
        
        return cell
    }
    
    ///Table View Cell Setup
    /// GuestHosts Cell
    /// - Parameters:
    ///   - cell: GuestHostsTVCell
    ///   - indexPath: IndexPath
    func QuickStatsCell(cell: QuickStatsTVCell, indexPath: IndexPath) {
        print(indexPath.section)
    }
}

//MARK:- TableView Delegate
extension QuickStatsViewController: UITableViewDelegate {
    
    /// Height For Row At indexPath
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30.0
    }
    
    /// Did Select Row At indexPath
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}

extension QuickStatsViewController: PassTeamToQuickStatsDelegate {
    func passTeam(_ team: Team) {
        self.teamFromMainVC = team
        self.tableView.reloadData()
    }
}

extension QuickStatsViewController: ReloadQStatsTableView {
    func reloadTableView() {
        print("quickstats tableView was reloaded")
        self.tableView.reloadData()
    }
    
    
}


