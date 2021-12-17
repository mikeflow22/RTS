//
//  TeamStatsViewController.swift
//  RealTimeStats
//
//  Created by Debbi Chandel on 10/12/21.
//

import UIKit
import MessageUI

class TeamStatsViewController: UIViewController {
    
    //MARK: IBOUTLET'S
    
    /// Team name
    @IBOutlet weak var teamNameLbl: UILabel! {
        didSet {
            teamNameLbl.text = self.teamObj?.name
        }
    }
    
    /// Header View
    @IBOutlet weak var headerView: UIView!
    
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
        btn1.addTarget(self, action: #selector(TeamStatsViewController.menuBtnPressed), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: btn1)
        self.navigationItem.setRightBarButtonItems([item1], animated: true)
    }
    
    //MARK: IBACTIONS
    @objc func menuBtnPressed() {
    }
    
    //MARK: Share Stats
    func shareStats(cell: TeamStatsTVCell) {
        
        /// Create the player stats content
        let emailBody = "Player: \(cell.playerNameLbl.text! ) \nPts: \(cell.ptsLbl.text! ) \n2FG: \(cell.twoFgLbl.text! ) \n3FG: \(cell.threeFgLbl.text! ) \nReb: \(cell.rebLbl.text! ) \nAst: \(cell.astLbl.text! ) \nStl: \(cell.stlLbl.text! ) \nBIK: \(cell.bikLbl.text! ) \nTo: \(cell.toLbl.text! ) \nD-eff: \(cell.deffLbl.text! ) \nO-eff: \(cell.oeffLbl.text! ) \nPER: \(cell.perLbl.text! )"
        
        /// Share player stats
        self.showCustomAlert(view: self, title: "Are you sure?", message: "You want to share \(cell.playerNameLbl!.text ?? "") stats?") { choice in
            if choice {
                self.showMailComposer(subject: "\(cell.playerNameLbl.text! ) real time stats", body: emailBody)
            }
        }
        
    }
    
    /// Share to email address
    func showMailComposer(subject: String,body: String){
        
        print("Email subject:- \(subject)")
        print("Email body:-\n\(body)")
        
        guard MFMailComposeViewController.canSendMail() else {
            print("Mail not working on simulator. Check in real device")
            return
        }
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setToRecipients(["abc@gmail.com"]) // email id of the recipient
        composer.setSubject(subject)
        composer.setMessageBody(body, isHTML: false)
        present(composer, animated: true, completion: nil)
    }
}

//MARK: Mail composer delegate method
extension TeamStatsViewController: MFMailComposeViewControllerDelegate {
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        if let _ = error {
            print(error?.localizedDescription as Any)
            controller.dismiss(animated: true, completion: nil)
            return
        }
        controller.dismiss(animated: true, completion: nil)
    }
    
}
