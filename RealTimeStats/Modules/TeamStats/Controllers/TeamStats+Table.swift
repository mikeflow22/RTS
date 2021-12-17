//
//  TeamStats+TB.swift
//  RealTimeStats
//
//  Created by Debbi Chandel on 13/12/21.
//

import Foundation
import UIKit

//MARK: TableView DataSource
extension TeamStatsViewController: UITableViewDataSource {
    
    /// Number Of Rows In Section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teamObj?.players.count ?? 0
    }
    
    /// Cell For Row At indexPath
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! TeamStatsTVCell
        cell.selectionStyle = .none
        
        /// TeamStats Cell
        if let team = self.teamObj {
            TeamStatsCell(cell: cell, team: team, indexPath: indexPath)
        }
        
        return cell
    }
    
    ///Collection View Cell Setup
    /// User Cell
    /// - Parameters:
    ///   - cell: TeamStatsTVCell
    ///   - indexPath: IndexPath
    func TeamStatsCell(cell: TeamStatsTVCell,team: Team, indexPath: IndexPath) {
        print(indexPath.row)
        let teamPlayerObj = team.players[indexPath.row]
        cell.playerNameLbl.text = teamPlayerObj.name
    }
    
    
}

//MARK: TableView Delegate
extension TeamStatsViewController: UITableViewDelegate {
    
    /// Did Select Row At indexPath
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let indexPath = tableView.indexPathForSelectedRow
        let currentCell = tableView.cellForRow(at: indexPath!) as! TeamStatsTVCell
        self.shareStats(cell: currentCell)
    }
    
    /// Height For Row At indexPath
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    /// Table Header Height
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    /// Table Footer Height
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
}

