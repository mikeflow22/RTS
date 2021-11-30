//
//  PlayByPlayVC.swift
//  RealTimeStats
//
//  Created by Debbi Chandel on 20/11/21.
//

import UIKit

class PlayByPlayVC: UIViewController {
    let identifier = "PlayByPlayTVCell"
    var shouldBeginToEdit: Bool? {
        didSet {
            print("pbp edit button should edit")
        }
    }
    var mainVC: MainVC? {
        didSet {
            print("MainVC variable was set in PlayByPlayVC")
        }
    }

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
        mainVC?.reloadPBPTableView = self
        mainVC?.editPlayByPlay = self
    }
}

//MARK:- TableView DataSource
extension PlayByPlayVC: UITableViewDataSource {
    
    /// Number Of Rows In Section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PlayByPlayViewModel.plays.count > 0 ? PlayByPlayViewModel.plays.count : 1
    }
    
    /// Cell For Row At indexPath
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          var cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! PlayByPlayTVCell
        
        if PlayByPlayViewModel.plays.count > 0 {
            let play = PlayByPlayViewModel.plays[indexPath.row]
            cell.breaksLabel.text = "\(play.action.breaks)"
            cell.timeLabel.text = "\(play.action.time)"
            cell.playerNameLabel.text = play.player.name
            cell.statLabel.text = play.action.stat.rawValue
            
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! PlayByPlayTVCell
        }

        cell.backgroundColor = UIColor.clear
        cell.selectionStyle = .none
        
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        let playToDelete = PlayByPlayViewModel.plays[indexPath.row]
        if shouldBeginToEdit == true {
            if editingStyle == .delete {
                PlayByPlayViewModel.plays.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .left)
                shouldBeginToEdit = false
            }
        }
    }
}

//MARK:- TableView Delegate
extension PlayByPlayVC: UITableViewDelegate {
    
    /// Height For Row At indexPath
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30.0
    }
    
    /// Did Select Row At indexPath
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    
    
}

extension PlayByPlayVC: ReloadPbPTableView {
    //this delegate should reload the tableView
    func reloadTableView() {
        print("should reload tableView becasue delegate trigger was hit")
        self.tableView.reloadData()
    }
}

extension PlayByPlayVC: EditPlayByPlayDelegate {
    func shouldEdit(_ bool: Bool) {
        self.shouldBeginToEdit = bool
    }
}
