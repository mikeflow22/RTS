//
//  PlayerTableViewCell.swift
//  RealTimeStats
//
//  Created by Michael Flowers on 10/24/21.
//

import UIKit

class PlayerTableViewCell: UITableViewCell {

    static let reuseIdentifier = "PlayerCell"
    
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var foulLabel: UILabel!
    
    static func returnNib() -> UINib {
        return UINib(nibName: "PlayerTableViewCell", bundle: nil)
    }
    
    func setupPlayerCell(withPlayerViewModel player: PlayerViewModel) {
        numberLabel.text = "\(player.number)"
        nameLabel.text = player.name
        foulLabel.text = "\(player.rebounds)"
        
    }
    
}
