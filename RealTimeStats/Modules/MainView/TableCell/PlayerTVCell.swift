//
//  UserTVCell.swift
//  RealTimeStats
//
//  Created by Debbi Chandel on 11/11/21.
//

import UIKit

class PlayerTVCell: UITableViewCell {
    
    //MARK:- IBOUTLET'S
    /// Main View
    @IBOutlet weak var mainView: UIView!{
        didSet {
            self.mainView.layer.borderWidth = 0.5
            self.mainView.gradientViewBorder(color1: Color.userCellViewBorderGradientColor1, color2: Color.userCellViewBorderGradientColor2)
        }
    }
    
    /// User ID
    @IBOutlet weak var userIdLbl: UILabel!
    
    /// User Name
    @IBOutlet weak var userNameLbl: UILabel!
    
    /// Goal 1
    @IBOutlet weak var goal1Lbl: UILabel!
    
    /// Goal 2
    @IBOutlet weak var goal2Lbl: UILabel!
    
    /// Goal 3
    @IBOutlet weak var goal3Lbl: UILabel!
    
    /// Goal 4
    @IBOutlet weak var goal4Lbl: UILabel!
    
    /// Goal 5
    @IBOutlet weak var goal5Lbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0))
    }
    
}
