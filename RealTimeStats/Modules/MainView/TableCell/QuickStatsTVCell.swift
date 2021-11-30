//
//  GuestHostsTVCell.swift
//  RealTimeStats
//
//  Created by Debbi Chandel on 15/11/21.
//

import UIKit

class QuickStatsTVCell: UITableViewCell {

    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var reboundLabel: UILabel!
    @IBOutlet weak var assistLabel: UILabel!
    
    //what do i do with the label?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
