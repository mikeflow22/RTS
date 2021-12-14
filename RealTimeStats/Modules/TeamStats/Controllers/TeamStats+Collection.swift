//
//  TeamStats+Collection.swift
//  RealTimeStats
//
//  Created by Debbi Chandel on 13/12/21.
//

import Foundation
import UIKit

//MARK: CollectionView DataSource
extension TeamStatsViewController: UICollectionViewDataSource {
    
    /// Number Of Rows In Section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 11
    }
    
    /// Cell For Row At indexPath
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let identifier = "TeamStatsCVCell"
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! TeamStatsCVCell
        cell.backgroundColor = UIColor.clear
        
        if let team = self.teamObj {
            /// TeamStats Cell
            TeamStatsCell(cell: cell, team: team, indexPath: indexPath)
        } else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! TeamStatsCVCell
        }
        return cell
    }
    
    ///Collection View Cell Setup
    /// User Cell
    /// - Parameters:
    ///   - cell: TeamStatsCVCell
    ///   - indexPath: IndexPath
    func TeamStatsCell(cell: TeamStatsCVCell,team: Team, indexPath: IndexPath) {
        print(indexPath.row)
    }
}

//MARK: CollectionView Delegate
extension TeamStatsViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}

//MARK: CollectionView Flow Layout Delegate
extension TeamStatsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 235.0, height: 82.0)
    }
}
