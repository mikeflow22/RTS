//
//  TeamStatsTVCell.swift
//  RealTimeStats
//
//  Created by Debbi Chandel on 13/12/21.
//

import UIKit

class TeamStatsTVCell: UITableViewCell {

    //MARK: IBOUTLET'S
    ///Player Name
    @IBOutlet weak var playerNameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
