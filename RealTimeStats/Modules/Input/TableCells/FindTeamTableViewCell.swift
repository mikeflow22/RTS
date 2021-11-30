//
//  FindTeamTableViewCell.swift
//  RealTimeStats
//
//  Created by Michael Flowers on 11/24/21.
//

import UIKit

class FindTeamTableViewCell: UITableViewCell {

    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var teamGradeLabel: UILabel!
    @IBOutlet weak var teamGenderLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
