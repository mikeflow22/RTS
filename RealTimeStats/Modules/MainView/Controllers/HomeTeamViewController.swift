//
//  RightPlayersVC.swift
//  RealTimeStats
//
//  Created by Debbi Chandel on 20/11/21.
//

import UIKit

class HomeTeamViewController: UIViewController, PassActionToHomeTeamDelegate, CancelActionForHomeTeamDelegate {
    func actionToPass(_ action: Action) {
        self.actionPassedToHomeTeamVC = action
    }
    func setActionToNil() {
        self.actionPassedToHomeTeamVC = nil
    }
    
    //MARK: - Properties
    var player: Player? {
        didSet {
            print("player was set in homeTeamVC")
        }
    }
    
    var actionPassedToHomeTeamVC: Action? {
        didSet {
            if actionPassedToHomeTeamVC != nil {
                print("Action was passed from MainVC to homeTeamVC")
            } else {
                print("action in homeTeamVC was set to nil")
            }
        }
    }
    
    var tc: TournamentController? {
        didSet {
            print("TC set in AwayTeamVC")
        }
    }
    var mainVC: MainVC? {
        didSet {
            print("passed the mainVC to HomeTeamViewController for delegate pattern communication")
        }
    }
    var homeTeam: Team? {
        didSet {
            print("Home team was set")
        }
    }
    
    let identifier = "PlayerTVCell"
    ///
    /// OUTLETS
    ///
    /// Reload Button
    @IBOutlet weak var reloadBtn: UIButton!{
        didSet {
            self.reloadBtn.gradientButtonBorder(color1: Color.reloadButtonBorderGradientColor, color2: Color.reloadButtonBorderGradientColor)
        }
    }
    
    /// Table View
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
            tableView.backgroundColor = UIColor.clear
        }
    }
    
    /// Substitution View Propertie
    var substitutionView = SubstitutionView()
    var isSubstitutionViewOpen: Bool = false
    var replacePlayerIndex: Int = -1
    
    /// Selected player row highlight
    var selectedPlayerRow: Int = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainVC?.passActionToHomeTeam = self
        mainVC?.cancelActionForHomeTeam = self
        self.tc = TournamentController()
    }
    
    //MARK:- IBACTIONS
    @IBAction func ReloadButtonWasPressed(_ sender: UIButton) {
        
        self.isSubstitutionViewOpen = true
        substitutionView = SubstitutionView(frame: CGRect(x: 175, y: 200, width: 670, height: 250))
        substitutionView.teamObj = self.homeTeam
        substitutionView.onSelection = {(_ index: Int?) in
            if index != -1 {
                self.replacePlayerIndex = index ?? 0
                self.replacePlayer(index: self.selectedPlayerRow)
            }
            self.selectedPlayerRow = -1
            self.isSubstitutionViewOpen = false
        }
        substitutionView.transform = CGAffineTransform(scaleX: 0, y: 0)
        mainVC?.view!.addSubview(substitutionView)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 5, options: .curveEaseInOut, animations: {() -> Void in
            self.substitutionView.transform = .identity
        }, completion: { _ in })
    }
    
}

//MARK: - TableView DataSource
extension HomeTeamViewController: UITableViewDataSource {
    
    /// Number Of Rows In Section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    // TableView Header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0.0))
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    // TableView Footer
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 15.0))
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    /// Cell For Row At indexPath
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! PlayerTVCell
        
        if let homeTeam = self.homeTeam {
            let player = homeTeam.players[indexPath.row]
            cell.userNameLbl.text = player.name
            cell.userIdLbl.text = "# \(player.number)"
            
            /// Added By Debbi
            if self.selectedPlayerRow == indexPath.row {
                cell.mainView.borderColor = UIColor.white
                cell.userIdLbl.textColor = Color.topSegmentBorderColor
                cell.userNameLbl.textColor = Color.topSegmentBorderColor
            } else {
                cell.mainView.borderColor = Color.userCellViewBorderGradientColor1
                cell.userIdLbl.textColor = UIColor.white
                cell.userNameLbl.textColor = UIColor.white
            }
            
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! PlayerTVCell
        }
        
        cell.backgroundColor = UIColor.clear
        cell.selectionStyle = .none
        
        return cell
    }
    
}

//MARK: - TableView Delegate
extension HomeTeamViewController: UITableViewDelegate {
    func addStat(_ stat: Stats, toPlayer player: Player) {
        switch stat {
        case .offFoul: player.offFoul += 1
        case .defFoul: player.deffFoul += 1
        case .oRebound: player.oRebound += 1
        case .dRebound: player.dRebound += 1
        case .madeFreethrow: player.madeFreethrow += 1
        case .missedFreethrow: player.missedFreethrow += 1
        case .block: player.block += 1
        case .assist: player.assist += 1
        case .steal: player.steal += 1
        case .turnover: player.turnover += 1
        case .jumpBall: player.jumpBallForced += 1
        case .madeA2pt: player.fgm2 += 1
        case .missedA2pt: player.fga2 += 1
        case .madeA3pt: player.fgm3 += 1
        case .missedA3pt: player.fga3 += 1
        }
    }
    
    /// Did Select Row At indexPath
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let homeTeam = self.homeTeam else {
            print("no home team or away team")
            return
        }
        
        /// Added By Debbi
        if self.isSubstitutionViewOpen {
            self.selectedPlayerRow = indexPath.row
            self.tableView.reloadData()
        }
        
        player = homeTeam.players[indexPath.row]
        guard let unwrappedPlayer = self.player else {
            print("couldn't unwrap player in homeTeamVC")
            return
        }
        print(indexPath.row)
        print("player was selected: \(unwrappedPlayer.name)")
        
        guard let unwrappedAction = self.actionPassedToHomeTeamVC else {
            print("couldn't unwrap action in hometeamVC")
            return
        }
        
        //switch on stat and increase player's property
        addStat(unwrappedAction.stat, toPlayer: unwrappedPlayer)
        print("\(unwrappedPlayer.name) recorded this stat: \(unwrappedAction.stat.rawValue)")
        
        
        //create play and pass it to MainVC
        guard let unwrappedMainVC = self.mainVC else {
            print("player was selected but no mainVC access")
            return
        }
        
        let play = PlayByPlayViewModel.createPlayWith(player: unwrappedPlayer, andAction: unwrappedAction)
        
        // add play to player's array
        unwrappedPlayer.plays.append(play)
        if let shot = play.action.shot {
            unwrappedPlayer.shots.append(shot)
        }
        print("player: \(unwrappedPlayer.name) has these many plays: \(unwrappedPlayer.plays.count) and these many shots: \(unwrappedPlayer.shots.count)")
        
        //Send Play back to MainVC so it can trigger the delegatee
        unwrappedMainVC.play = play
    }
    
    /// Replace active player with subsitution player
    func replacePlayer(index: Int) {
        
        self.substitutionView.removeFromSuperview()
        let activePlayer = self.homeTeam!.players[index]
        let substitudePlayer = self.homeTeam!.players[replacePlayerIndex]
        
        /// Replace substition player with active player
        self.homeTeam?.players.remove(at: index)
        self.homeTeam?.players.insert(substitudePlayer, at: index)
        
        /// Replace active player with substition player
        self.homeTeam?.players.remove(at: replacePlayerIndex)
        self.homeTeam?.players.insert(activePlayer, at: replacePlayerIndex)
        
        self.replacePlayerIndex = -1
        self.tableView.reloadData()
        
    }
    
    /// Height For Row At indexPath
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105.0
    }
    
    /// Table Header Height
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    /// Table Footer Height
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
}
