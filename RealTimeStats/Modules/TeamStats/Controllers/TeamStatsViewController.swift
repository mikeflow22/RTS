//
//  TeamStatsViewController.swift
//  RealTimeStats
//
//  Created by Debbi Chandel on 10/12/21.
//

import UIKit

class TeamStatsViewController: UIViewController {
    
    //MARK: IBOUTLET'S
    
    /// Header View
    @IBOutlet weak var headerView: UIView!{
        didSet {
            //headerView.backgroundColor = .white
            //headerView.alpha = 0.8
            //headerView.layer.backgroundColor = UIColor(red: 0.756, green: 0.985, blue: 1, alpha: 0.42).cgColor
        }
    }
    
    /// Team stats collection view
    @IBOutlet weak var teamStatsCollectionView: UICollectionView!{
        didSet {
            teamStatsCollectionView.register(UINib(nibName: "TeamStatsCVCell", bundle: nil), forCellWithReuseIdentifier: "TeamStatsCVCell")
            teamStatsCollectionView.delegate = self
            teamStatsCollectionView.dataSource = self
        }
    }
    
    /// Team stats table view
    let identifier = "TeamStatsTVCell"
    @IBOutlet weak var teamStatsTableView: UITableView!{
        didSet {
            teamStatsTableView.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
            teamStatsTableView.delegate = self
            teamStatsTableView.dataSource = self
            teamStatsTableView.backgroundColor = UIColor.clear
        }
    }
    
    /// Team
    var teamObj: Team? {
        didSet {
            print("Team was set in substitution view")
        }
    }
    
    //MARK: View Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// Navigation Setup
        navigationBarSetup()
    }
    
    //MARK: Navigation Bar  Setup
    func navigationBarSetup() {
        
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        self.navigationController?.isNavigationBarHidden = false
        
        let btn1 = UIButton(type: .custom)
        btn1.setImage(UIImage(named: "Menu"), for: .normal)
        btn1.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn1.addTarget(self, action: #selector(TeamStatsViewController.manuBtnPressed), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: btn1)
        
        let btn2 = UIButton(type: .custom)
        btn2.setImage(UIImage(named: "Share"), for: .normal)
        btn2.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn2.addTarget(self, action: #selector(TeamStatsViewController.shareBtnPressed), for: .touchUpInside)
        let item2 = UIBarButtonItem(customView: btn2)
        self.navigationItem.setRightBarButtonItems([item1,item2], animated: true)
    }
    
    //MARK: IBACTIONS
    @objc func manuBtnPressed() {
        
    }
    
    @objc func shareBtnPressed() {
        
    }
    
}
