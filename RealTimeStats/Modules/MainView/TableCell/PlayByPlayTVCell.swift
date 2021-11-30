//
//  PlayByPlayTVCell.swift
//  RealTimeStats
//
//  Created by Debbi Chandel on 15/11/21.
//

import UIKit

class PlayByPlayTVCell: UITableViewCell {

    @IBOutlet weak var breaksLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var statLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
