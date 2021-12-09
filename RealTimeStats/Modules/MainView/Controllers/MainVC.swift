//
//  MainVC.swift
//  RealTimeStats
//
//  Created by Debbi Chandel on 09/11/21.
//

import UIKit

/// For Top Segment Buttons
enum Segments {
    case pending
    case completed
}

enum Breaks: Int {
    case halves = 2
    case quarters = 4
}

//MARK: - Protocol Delegates

protocol EditPlayByPlayDelegate: AnyObject {
    func shouldEdit(_ bool: Bool)
}
protocol PassTeamToQuickStatsDelegate: AnyObject {
    func passTeam(_ team: Team)
}

//pass action to TeamVCs
protocol PassActionToHomeTeamDelegate: AnyObject {
    func actionToPass(_ action: Action)
}

protocol PassActionToAwayTeamDelegate: AnyObject {
    func actionToPass(_ action: Action)
}

//cancel action in TeamVCs
protocol CancelActionForHomeTeamDelegate: AnyObject {
    func setActionToNil()
}

protocol CancelActionForAwayTeamDelegate: AnyObject {
    func setActionToNil()
}

protocol ReloadPbPTableView: AnyObject {
    func reloadTableView()
}

protocol ReloadQStatsTableView: AnyObject {
    func reloadTableView()
}

/// Segues
enum Segues {
    static let toPlayByPlayChild = "toPlayByPlayChild"
    static let toQuickStatsVC = "toQuickStatsVC"
    static let toAwayTeamVC = "toAwayTeamVC"
    static let toHomeTeamVC = "toHomeTeamVC"
}

class MainVC: UIViewController {
    //MARK: - Delegates
    weak var editPlayByPlay: EditPlayByPlayDelegate?
    weak var passTeam: PassTeamToQuickStatsDelegate?
    weak var passActionToHomeTeam: PassActionToHomeTeamDelegate?
    weak var passActionToAwayTeam: PassActionToAwayTeamDelegate?
    weak var cancelActionForHomeTeam: CancelActionForHomeTeamDelegate?
    weak var cancelActionForAwayTeam: CancelActionForAwayTeamDelegate?
    weak var reloadPBPTableView: ReloadPbPTableView?
    weak var reloadQStatsTableView: ReloadQStatsTableView?
    
    //MARK: - Properties
    var mockTournament: Tournament?
    var mockAwayTeam: Team?
    var mockHomeTeam: Team?
    var tc: TournamentController? {
        didSet {
            print("tc was set in MainVC")
        }
    }
    var game: Game? {
        didSet {
            print("Game was set in MainVC")
        }
    }
    var play: Play? {
        didSet {
            if let newPlay = play {
                print("play was passed to MainVC from one of the TeamPlayerVC")
                PlayByPlayViewModel.addPlayToPlaysArray(newPlay)
                reloadPBPTableView?.reloadTableView()
                reloadQStatsTableView?.reloadTableView()
                cancelActionForHomeTeam?.setActionToNil()
                cancelActionForAwayTeam?.setActionToNil()
            } else {
                print("did not pass play because there wasn't a play to pass")
            }
        }
    }
    var action: Action? {
        didSet {
            print("Action was set in MainVC and/or action was set to nil")
        }
    }
    var playerFoulLimit: Int?
    var foulBonusLimit: Int?
    var foulDoubleBonusLimit: Int?
    var breaks: Breaks?
    
    var awayTeamIsInBonus: Bool = false
    var awayTeamIsInDoubleBonus: Bool = false
    
    var homeTeamIsInBonus: Bool = false
    var homeTeamIsInDoubleBonus: Bool = false
    
    
    //MARK: - IBOUTLETS
    
    ///Away Team Scoreboard
    @IBOutlet weak var awayTeamNameLabel: UILabel!
    @IBOutlet weak var awayTeamScoreLabel: UILabel!
    @IBOutlet weak var awayTeamFoulsLabel: UILabel!
    @IBOutlet weak var awayTeamBonusLabel: UILabel!
    @IBOutlet weak var awayTeamPossessionArrow: UIButton!
    @IBAction func awayTeamPossessionArrowButtonPressed(_ sender: UIButton) {
    }
    
    ///Home Team Scoreboard
    @IBOutlet weak var homeTeamNameLabel: UILabel!
    @IBOutlet weak var homeTeamScoreLabel: UILabel!
    @IBOutlet weak var homeTeamFoulsLabel: UILabel!
    @IBOutlet weak var homeTeamBonusLabel: UILabel!
    @IBOutlet weak var homeTeamPosessionArrowAttributes: UIButton!
    @IBAction func homeTeamPossessionArrowBtnPressed(_ sender: UIButton) {
    }
    
    @IBOutlet weak var courtView: CourtView!
    
    @IBOutlet weak var gameTimeLabel: UILabel!
    @IBOutlet weak var HalvesOrQuartersSegmentedControlAttributes: UISegmentedControl!
    @IBAction func halvesOrQuartersValueChanged(_ sender: UISegmentedControl) {
    }
    
    //MARK: - Header Left View
    /// Left Header Expand View
    @IBOutlet weak var playByPlayExpendView: UIView! {
        didSet {
            playByPlayExpendView.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 15.0)
        }
    }
    /// Left Header Expand View Height Constraint
    @IBOutlet weak var playByPlayHeaderExpandViewHeightConstraint: NSLayoutConstraint!
    /// Top Left Header Expand View Status Check
    var isExpandPlayByPlay:Bool = false
    /// Top Container View Constraint
    @IBOutlet weak var playByPlayTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var playByPlayLbl: UILabel!
    
    @IBOutlet weak var editBtnView: UIView! {
        didSet {
            editBtnView.gradientViewBorder(color1: Color.reloadButtonBorderGradientColor, color2: Color.reloadButtonBorderGradientColor)
        }
    }
    
    /// PlayBtPlay List View
    @IBOutlet weak var PlayBtPlayListView: UIView!
    
    //MARK: - Header Middle View
    /// Middle Header Expand View
    @IBOutlet weak var scoreBoardHeaderExpendView: UIView! {
        didSet {
            scoreBoardHeaderExpendView.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 15.0)
        }
    }
    /// Middle Header Expand View Height Constraint
    @IBOutlet weak var scoreboardHeaderExpandViewHeightConstraint: NSLayoutConstraint!
    /// Middle Header Stack View
    @IBOutlet weak var topHeaderStackView: UIStackView!
    /// Top Header Expand View Status Check
    var isExpandScoreboardHeader:Bool = false
    
    //MARK: - Header Right View
    /// Right Header Expand View
    @IBOutlet weak var quickStatsHeaderExpendView: UIView! {
        didSet {
            quickStatsHeaderExpendView.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 15.0)
        }
    }
    /// Right Header Expand View Height Constraint
    @IBOutlet weak var quickStatsHeaderExpandViewHeightConstraint: NSLayoutConstraint!
    /// Right Left Header Expand View Status Check
    var isExpandQuickStatsHeader:Bool = false
    
    /// Top Segment(Guest and hosts)
    @IBOutlet weak var topSegmentView: UIView!
    
    /// TopSegment Guest Button
    @IBOutlet weak var awayTeamButtonAttributes: UIButton!
    
    /// TopSegment Hosts Button
    @IBOutlet weak var homeTeamButtonAttributes: UIButton!
    
    /// Selected Segment Bottom ImageView
    var imgTopSegmentBottomBorder: UIImageView!
    
    /// Selected Segment(Guest/Hosts)
    var segmentSelected: Segments = Segments.pending
    
    /// GuestHost List View
    @IBOutlet weak var awayTeamListView: UIView!
    
    /// Bottom View
    @IBOutlet weak var bottomView: UIView! {
        didSet {
            self.bottomView.gradientViewBorder(color1: Color.reloadButtonBorderGradientColor, color2: Color.reloadButtonBorderGradientColor)
        }
    }
    
    /// First Team View
    @IBOutlet weak var awayTeamView: UIView!
    
    /// Secound Team View
    @IBOutlet weak var homeTeamView: UIView!
    
    /// Timer
    @IBOutlet weak var gameTimerBtn: UIButton!
    var gameTimer = Timer()
    var gameTime = 90.0
    var isGameTimerPaused = true
    
    //MARK: - Private Functions
    func setupScoreboard(fromTournamentController tc: TournamentController?) {
        let tc = unwrapTournamentController(tournamentController: tc)
        guard let rules = tc.currentTournament?.rule, let game = self.game else {
            print("couldn't get rules from currentTournament.rule")
            return
        }
        
        //Team names
        awayTeamNameLabel.text = game.awayTeam.name
        homeTeamNameLabel.text = game.homeTeam.name
        
        //Fouls
        playerFoulLimit = rules.foulLimit
        foulBonusLimit = rules.bonusLimit
        foulDoubleBonusLimit = rules.doubleBonusLimit
        awayTeamFoulsLabel.text = "\(0)"
        homeTeamFoulsLabel.text = "\(0)"
        
        //Time
        guard let breaks = Breaks(rawValue: rules.halves) else {
            print("couldn't unwrap breaks")
            return
        }
        setBreaks(breaks)
        gameTimeLabel.text = "\(rules.timePerHalf)"
        
        //Scores
        awayTeamScoreLabel.text = "\(00)"
        homeTeamScoreLabel.text = "\(00)"
    }
    
    func unwrapTournamentController(tournamentController tc: TournamentController?) -> TournamentController {
        guard let unwrappedTC = tc else {
            print("didn't unwrap tc in function: \(#function)")
            fatalError()
        }
        return unwrappedTC
    }
    
    func setBreaks(_ breaks: Breaks) {
        
        if breaks.rawValue == HalvesOrQuartersSegmentedControlAttributes.numberOfSegments {
            //do nothing
            self.breaks = breaks
        } else  {
            HalvesOrQuartersSegmentedControlAttributes.removeSegment(at: 2, animated: true)
            print("should be 3 left: \(HalvesOrQuartersSegmentedControlAttributes.numberOfSegments)")
            
            HalvesOrQuartersSegmentedControlAttributes.removeSegment(at: 2, animated: true)
            print("should be 2 left: \(HalvesOrQuartersSegmentedControlAttributes.numberOfSegments)")
            HalvesOrQuartersSegmentedControlAttributes.setTitle("H1", forSegmentAt: 0)
            HalvesOrQuartersSegmentedControlAttributes.setTitle("H2", forSegmentAt: 1)
            self.breaks = breaks
        }
    }
    
    func setUPMockTournament() {
        mockTournament = Tournament(name: "Fake")
        let mockRules = Rule(halves: 2, timePerHalf: 60.00, foulLimit: 5, bonusLimit: 6, doubleBonusLimit: 10, timeouts: 5)
        mockTournament?.rule = mockRules
        let awayTeam = MockTeams.awayTeam
        let homeTeam = MockTeams.homeTeam
        let mockGame = Game(homeTeam: homeTeam, awayTeam: awayTeam)
        self.game = mockGame
        
        //Team names
        awayTeamNameLabel.text = game?.awayTeam.name
        homeTeamNameLabel.text = game?.homeTeam.name
        
        //Fouls
        playerFoulLimit = mockRules.foulLimit
        foulBonusLimit = mockRules.bonusLimit
        foulDoubleBonusLimit = mockRules.doubleBonusLimit
        awayTeamFoulsLabel.text = "\(0)"
        homeTeamFoulsLabel.text = "\(0)"
        homeTeamScoreLabel.text = "\(98)"
        awayTeamScoreLabel.text = "\(65)"
        
        //Time
        guard let breaks = Breaks(rawValue: rules.halves) else {
            print("couldn't unwrap breaks")
            return
        }
        setBreaks(breaks)
        gameTimeLabel.text = "\(mockRules.timePerHalf)"
        self.gameTime = rules.timePerHalf
    }
    
    //MARK: - VIEW LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        courtView.delegate = self
        setUPMockTournament()
        //        setupScoreboard(fromTournamentController: self.tc)
        
        //Top Guest/Hosts Segment Bottom
        imgTopSegmentBottomBorder = UIImageView.init(frame: CGRect.init(x: 0, y: 47, width: topSegmentView.frame.width/2, height: 3))
        imgTopSegmentBottomBorder.backgroundColor = Color.topSegmentBorderColor
        topSegmentView.addSubview(imgTopSegmentBottomBorder)
        awayTeamButtonAttributes.isSelected = true
    }
    
    //MARK: - LAYOUT SUBVIEWS
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    //MARK: - All SEGUES
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segues.toPlayByPlayChild {
            let destVC = segue.destination as! PlayByPlayVC
            destVC.mainVC = self
            //            print(destVC.view.frame)
            
        } else if segue.identifier == Segues.toQuickStatsVC {
            let destVC = segue.destination as! QuickStatsViewController
            destVC.mainVC = self
            //            guard let game = self.game else {
            //                print("problem here: \(#function) on line: \(#line)")
            //                return
            //            }
            //            destVC.game = game
            destVC.teamFromMainVC = MockTeams.awayTeam
            //            print(destVC.view.frame)
            
        } else if segue.identifier == Segues.toAwayTeamVC {
            guard let destVC = segue.destination as? AwayTeamViewController /*, let tc = self.tc, let game = self.game */else {
                print("no segue to awayTeamVC")
                return
            }
            destVC.tc = tc
            destVC.mainVC = self
            //            destVC.awayTeam = game.awayTeam
            destVC.awayTeam = MockTeams.awayTeam
            //            print(destVC.view.frame)
            
        } else if segue.identifier == Segues.toHomeTeamVC {
            guard let destVC = segue.destination as? HomeTeamViewController /*, let tc = self.tc, let game = self.game*/ else {
                print("no segue to homeTeamVC")
                return
            }
            destVC.tc = tc
            //            destVC.homeTeam = game.homeTeam
            destVC.homeTeam = MockTeams.homeTeam
            destVC.mainVC = self
            //            print(destVC.view.frame)
        }
    }
    //    func captureShot(withLocation location: CGPoint, type: Int, stats: Stats) -> Action {
    //        let shot = Shot(location: location, stats: .missedA3pt)
    ////        let action = Action(breaks: <#T##Breaks#>, time: <#T##Double#>, stat: /*shot: Shot  */)
    //    }
    
    func captureAction(withStat: Stats) -> Action {
        gameTimeLabel.text = "\(gameTime)"
        if let breaks = self.breaks, let time = gameTimeLabel.convertToDouble() {
            ///ActionViewModel/Controller
            let action = Action(breaks: breaks, time: time, stat: withStat)
            print("ActionCaptured: \(action.stat.rawValue)")
            return action
            //            return Action(breaks: breaks, time: time, stat: withStat)
        } else {
            return Action(breaks: .halves, time: 00.00, stat: .offFoul)
        }
    }
    
    //MARK: - IBACTIONS
    @IBAction func offensiveFoulButtonPressed(_ sender: UIButton) {
        print("off.foul button pressed")
        //actionViewModel
        //        let shot = Shot(location: CGPoint(x: 453.0, y: 245.94), stats: .missedA3pt, success: false)
        //        let shotAction = Action(breaks: .quarters, time: 00.00, stat: shot.stats, shot: shot)
        let action = captureAction(withStat: .offFoul)
        passActionToHomeTeam?.actionToPass(action)
        passActionToAwayTeam?.actionToPass(action)
    }
    
    @IBAction func deffensiveFoulButtonPressed(_ sender: UIButton) {
        //actionViewModel
        let action = captureAction(withStat: .defFoul)
        passActionToHomeTeam?.actionToPass(action)
        passActionToAwayTeam?.actionToPass(action)
    }
    
    @IBAction func madeFreethrowButtonPressed(_ sender: UIButton) {
        //actionViewModel
        let action = captureAction(withStat: .madeFreethrow)
        passActionToHomeTeam?.actionToPass(action)
        passActionToAwayTeam?.actionToPass(action)
    }
    
    @IBAction func missedFreethrowButtonPressed(_ sender: UIButton) {
        //actionViewModel
        let action = captureAction(withStat: .missedFreethrow)
        passActionToHomeTeam?.actionToPass(action)
        passActionToAwayTeam?.actionToPass(action)
    }
    
    @IBAction func blockButtonPressed(_ sender: UIButton) {
        //actionViewModel
        let action = captureAction(withStat: .block)
        passActionToHomeTeam?.actionToPass(action)
        passActionToAwayTeam?.actionToPass(action)
    }
    
    @IBAction func assistButtonPressed(_ sender: UIButton) {
        //actionViewModel
        let action = captureAction(withStat: .assist)
        passActionToHomeTeam?.actionToPass(action)
        passActionToAwayTeam?.actionToPass(action)
    }
    
    @IBAction func stealButtonPressed(_ sender: UIButton) {
        //actionViewModel
        let action = captureAction(withStat: .steal)
        passActionToHomeTeam?.actionToPass(action)
        passActionToAwayTeam?.actionToPass(action)
    }
    
    @IBAction func turnoverButtonPressed(_ sender: UIButton) {
        //actionViewModel
        let action = captureAction(withStat: .turnover)
        passActionToHomeTeam?.actionToPass(action)
        passActionToAwayTeam?.actionToPass(action)
    }
    
    @IBAction func oReboundButtonPressed(_ sender: UIButton) {
        //actionViewModel
        let action = captureAction(withStat: .oRebound)
        passActionToHomeTeam?.actionToPass(action)
        passActionToAwayTeam?.actionToPass(action)
    }
    
    @IBAction func dReboundButtonPressed(_ sender: UIButton) {
        //actionViewModel
        let action = captureAction(withStat: .dRebound)
        passActionToHomeTeam?.actionToPass(action)
        passActionToAwayTeam?.actionToPass(action)
    }
    
    @IBAction func jumpBallButtonPressed(_ sender: UIButton) {
        //actionViewModel
        let action = captureAction(withStat: .jumpBall)
        passActionToHomeTeam?.actionToPass(action)
        passActionToAwayTeam?.actionToPass(action)
    }
    
    @IBAction func editButtonPressedForPlayByPlay(_ sender: UIButton) {
        editPlayByPlay?.shouldEdit(true)
        if isExpandPlayByPlay == false {
            view.layoutIfNeeded()
            playByPlayHeaderExpandViewHeightConstraint.constant = 350
            isExpandPlayByPlay = true
            
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            } completion: { success in
                if success == true {
                }
            }
        } else {
            view.layoutIfNeeded()
            self.playByPlayHeaderExpandViewHeightConstraint.constant = 90
            isExpandPlayByPlay = false
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        }
    }
    
    /// Top Header left view extend and collapse handler
    /// - Parameter sender: UIButton
    @IBAction func playByPlayHeaderExpandBtnPressed(_ sender: UIButton) {
        
        if isExpandPlayByPlay == false {
            view.layoutIfNeeded()
            self.playByPlayLbl.isHidden = false
            self.editBtnView.isHidden = false
            playByPlayTopConstraint.constant = 89.0
            playByPlayHeaderExpandViewHeightConstraint.constant = 350
            isExpandPlayByPlay = true
            self.PlayBtPlayListView.backgroundColor = UIColor(hexString: "#C1FBFF").withAlphaComponent(0.42)
            //self.PlayBtPlayListView.isOpaque = true
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            } completion: { success in
                if success == true {
                }
            }
            
        } else {
            view.layoutIfNeeded()
            self.playByPlayLbl.isHidden = true
            self.editBtnView.isHidden = true
            playByPlayTopConstraint.constant = 5.0
            self.playByPlayHeaderExpandViewHeightConstraint.constant = 90
            isExpandPlayByPlay = false
            self.PlayBtPlayListView.backgroundColor = UIColor.clear
            //self.PlayBtPlayListView.isOpaque = false
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        }
        
    }
    
    /// Top Header middle view extend and collapse handler
    /// - Parameter sender: UIButton
    @IBAction func scoreboardExpandBtnPressed(_ sender: UIButton) {
        
        if isExpandScoreboardHeader == false {
            view.layoutIfNeeded()
            scoreboardHeaderExpandViewHeightConstraint.constant = 120
            isExpandScoreboardHeader = true
            
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            } completion: { success in
                if success == true {
                    self.topHeaderStackView.isHidden = false
                }
            }
            
        } else {
            topHeaderStackView.isHidden = true
            view.layoutIfNeeded()
            self.scoreboardHeaderExpandViewHeightConstraint.constant = 90
            isExpandScoreboardHeader = false
            UIView.animate(withDuration: 0.3, animations: {
                self.topHeaderStackView.isHidden = true
                self.view.layoutIfNeeded()
            })
        }
    }
    
    /// Top Header right view extend and collapse handler
    /// - Parameter sender: UIButton
    @IBAction func quickStatsHeaderExpandBtnPressed(_ sender: UIButton) {
        
        if isExpandQuickStatsHeader == false {
            //            passTeam?.passTeam(MockTeams.awayTeam)
            view.layoutIfNeeded()
            quickStatsHeaderExpandViewHeightConstraint.constant = 350
            isExpandQuickStatsHeader = true
            
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            } completion: { success in
                if success == true {
                }
            }
            
        } else {
            view.layoutIfNeeded()
            self.quickStatsHeaderExpandViewHeightConstraint.constant = 90
            isExpandQuickStatsHeader = false
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        }
    }
    
    ///Top Segment Guest Button
    /// - Parameter sender: UIButton
    @IBAction func awayTeamBtnPressed(_ sender: Any) {
        segmentSelected = Segments.pending
        awayTeamButtonAttributes.isSelected = true
        homeTeamButtonAttributes.isSelected = false
        passTeam?.passTeam(MockTeams.awayTeam)
        //        if let awayTeam = game?.awayTeam {
        //            passAwayTeam?.passAway(awayTeam)
        //        } else {
        //            print("AwayTeam not set. Cannot pass to quickStatsVC")
        //        }
        
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseOut, animations: {
            self.imgTopSegmentBottomBorder.transform = .identity
        }, completion: nil)
    }
    
    ///Top Segment Hosts Button
    /// - Parameter sender: UIButton
    @IBAction func homeTeamBtnPressed(_ sender: Any) {
        segmentSelected = Segments.completed
        homeTeamButtonAttributes.isSelected = true
        awayTeamButtonAttributes.isSelected = false
        passTeam?.passTeam(MockTeams.homeTeam)
        //        passHomeTeam?.passHome(MockTeams.homeTeam)
        //        if let homeTeam = game?.homeTeam {
        //            passHomeTeam?.passHome(homeTeam)
        //        } else {
        //            print("HomeTeam not set. Cannot pass to quickStatsVC")
        //        }
        
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseOut, animations: {
            self.imgTopSegmentBottomBorder.transform = CGAffineTransform.init(translationX: self.topSegmentView.frame.width/2, y: 0)
        }, completion: nil)
    }
    
    @IBAction func gameTimerBtnPressed(_ sender: Any) {
        runGameTimer()
    }
    
    //MARK: - Game Timer
    func runGameTimer() {
        
        if isGameTimerPaused{
            self.gameTimerBtn.setImage(UIImage(named: "pause"), for: .normal)
            gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateGameTimer)), userInfo: nil, repeats: true)
            isGameTimerPaused = false
        } else {
            self.gameTimerBtn.setImage(UIImage(named: "play"), for: .normal)
            gameTimer.invalidate()
            isGameTimerPaused = true
        }
    }
    
    /// Update Timer
    @objc func updateGameTimer() {
        if gameTime < 1 {
            gameTimer.invalidate()
        } else {
            gameTime -= 1
            self.gameTimeLabel.text = timeCalcution(time: TimeInterval(gameTime))
        }
    }
    
    /// Calculate the time
    func timeCalcution(time: TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        //return String(format: "%02i : %02i : %02i", hours, minutes, seconds)
        return String(format: "%02i : %02i", minutes, seconds)
    }
    
    //MARK: - CourtDelegate Properties
    let BALL_SIZE: CGFloat = 28
    let MAX_BALLS: Int = 5
    var balls: [UIView] = []
}

extension MainVC: CourtDelegate {
    func addBall(withColor: UIColor, text: String, textColor: UIColor, x: CGFloat, y: CGFloat) {
        // Construct the subview for the ball
        let ball = UIView()
        ball.translatesAutoresizingMaskIntoConstraints = false
            // Turns off auto resizing so we can specify the size and position with constraints
        ball.backgroundColor = withColor
        ball.layer.cornerRadius = BALL_SIZE / 2.0       // makes it round
        ball.clipsToBounds = true                       // makes it round
        
        // Add a label to the ball
        let ballLabel = UILabel(frame: CGRect(x: 2, y: 2, width: BALL_SIZE-4, height: BALL_SIZE-4))
        ballLabel.textColor = textColor
        ballLabel.textAlignment = .center
        ballLabel.font = UIFont.systemFont(ofSize: BALL_SIZE-8)
        ball.addSubview(ballLabel)
        ballLabel.text = text
        
        // Set the height and width of the view
        ball.addConstraint(NSLayoutConstraint(item: ball, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: BALL_SIZE))
        ball.addConstraint(NSLayoutConstraint(item: ball, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: BALL_SIZE))
        
        // Add the subview to the court view
        self.courtView.addSubview(ball)
        
        // Add the x and y offsets as constraints using multipliers
        let xMultiplier: CGFloat = x
        let yMultiplier: CGFloat = y
        courtView.addConstraint(NSLayoutConstraint(item: ball, attribute: .trailing, relatedBy: .equal, toItem: courtView, attribute: .trailing, multiplier: xMultiplier, constant: BALL_SIZE/2))
        courtView.addConstraint(NSLayoutConstraint(item: ball, attribute: .bottom, relatedBy: .equal, toItem: courtView, attribute: .bottom, multiplier: yMultiplier, constant: BALL_SIZE/2))

        // Add the new ball to the list
        balls.append(ball)
    }
    
    func sendShotAction(hit: Shot) {
        let action = captureAction(withStat: hit.stats)
        action.shot = hit
        passActionToAwayTeam?.actionToPass(action)
        passActionToHomeTeam?.actionToPass(action)
    }
    
    // This is called whenever there is a tap in the court area. The x and y coordinates are given as a percentage of the
    // CourtView's width and height, not as absolute values. This function shows how to place a subview in the court area
    // using those values.
    func hitRegistered(hit: Shot) {
        if hit.stats == .madeA2pt {
            addBall(withColor: .green, text: "\(hit.points)", textColor: .black, x: hit.x, y: hit.y)
            sendShotAction(hit: hit)
        } else if hit.stats == .missedA2pt {
            addBall(withColor: .red, text: "X", textColor: .white, x: hit.x, y: hit.y)
            sendShotAction(hit: hit)
        } else if hit.stats == .madeA3pt {
            addBall(withColor: .green, text: "\(hit.points)", textColor: .black, x: hit.x, y: hit.y)
            sendShotAction(hit: hit)
        } else if hit.stats == .missedA3pt {
            addBall(withColor: .red, text: "X", textColor: .white, x: hit.x, y: hit.y)
            sendShotAction(hit: hit)
        }
    }
}
