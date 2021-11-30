//
//  ViewController.swift
//  RealTimeStats
//
//  Created by Michael Flowers on 10/23/21.
//

import UIKit

//the highest level vc has access to all of its children - here's where you set delegates (for buttons)
protocol ReboundButtonViewDelegate: AnyObject {
    func addRebound()
    func addStat(statString: String)
}

protocol PassPlayDelegate: AnyObject {
    func passPlay(_ play: Action)
}

class MainViewController1: UIViewController {
    var homeTeamPlayByPlayDelegate: HomeTeamPlayerVC? {
        didSet {
            print("homeTeamPlayByPlayDelegate was set")
        }
    }
    var tempPlayer: Player? {
        didSet {
            print("player: \(String(describing: tempPlayer?.name)) was set in MainVC")
        }
    }
    var playToSend: Action? {
        didSet {
            print("playToSend was set from selecting player in the HTPVC tableView cell")
            //delegate
            guard let play = playToSend else {
                print("there was no play to send")
                return
            }
            playDelegate?.passPlay(play)
        }
    }
    
    var tempRebound = 0
    weak var reboundDelegate: ReboundButtonViewDelegate?
    weak var playDelegate: PassPlayDelegate?
    
    @IBOutlet weak var reboundButtonAttributes: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
}


