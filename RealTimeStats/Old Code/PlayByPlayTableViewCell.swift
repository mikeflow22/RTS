//
//  PlayByPlayTableViewCell.swift
//  RealTimeStats
//
//  Created by Michael Flowers on 11/1/21.
//

import UIKit

class PlayByPlayTableViewCell: UITableViewCell {

    static let reuseIdentifier = "PlayByPlayCell"
    
    @IBOutlet weak var quarterLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var statLabel: UILabel!
    
    static func returnNib() ->UINib {
        return UINib(nibName: "PlayByPlayTableViewCell", bundle: nil)
    }
    
//    func setupPlayByPlayCell() {
//        for play in PlayByPlayViewModel.playByPlays {
//            quarterLabel.text = "\(play.breaks.rawValue)"
//            timeLabel.text = "12:39"
//            statLabel.text = play.stat.rawValue
//        }
//    }
    
    func setupPlayForCell(playbyplay: Action) {
        quarterLabel.text = "\(playbyplay.breaks.rawValue)"
        timeLabel.text = "\(playbyplay.time)"
        statLabel.text = playbyplay.stat.rawValue
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
