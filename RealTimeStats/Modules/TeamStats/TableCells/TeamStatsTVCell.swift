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
    
    ///Pts
    @IBOutlet weak var ptsLbl: UILabel!
    
    ///2FG
    @IBOutlet weak var twoFgLbl: UILabel!
    
    ///3FG
    @IBOutlet weak var threeFgLbl: UILabel!
    
    ///Reb
    @IBOutlet weak var rebLbl: UILabel!
    
    ///Ast
    @IBOutlet weak var astLbl: UILabel!
    
    ///Stl
    @IBOutlet weak var stlLbl: UILabel!
    
    ///BIK
    @IBOutlet weak var bikLbl: UILabel!
    
    ///To
    @IBOutlet weak var toLbl: UILabel!
    
    ///D-eff
    @IBOutlet weak var deffLbl: UILabel!
    
    ///o-eff
    @IBOutlet weak var oeffLbl: UILabel!
    
    //PER
    @IBOutlet weak var perLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
