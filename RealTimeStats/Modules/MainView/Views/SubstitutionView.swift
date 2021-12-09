//
//  FilesFolderView.swift
//  Cudo
//
//  Created by Debbi Chandel on 03/12/21.
//

import UIKit

/// SubstitutionView
class SubstitutionView: UIView {
    
    /// When row clicked then this callback will be returned with selected values
    var onSelection: ((_ index: Int?) -> Void)?
    
    /// Substitution Player modal
    private var SubstitutionPlayerArr: [SubstitutionPlayerModal]?
    
    ///
    /// OUTLETS
    ///
    /// Main content view
    @IBOutlet weak var mainView: UIView!
    
    /// Collection View
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.register(UINib(nibName: "SubstitutionCVCell", bundle: nil), forCellWithReuseIdentifier: "SubstitutionCVCell")
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    
    /// Confirm Button
    @IBOutlet weak var confirmBtn: UIButton!
    
    /// Team
    var teamObj: Team? {
        didSet {
            print("Team was set in substitution view")
        }
    }
    
    /// Selected player row highlight
    var selectedPlayerRow: Int = -1
    
    
    //MARK:- INIT
    
    /// Init
    /// - Parameter aDecoder: NSCoder
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        initializeSubviews()
    }
    
    /// Init
    /// - Parameter frame: CGRect
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeSubviews()
    }
    
    /// Initialize Subviews
    private func initializeSubviews() {
        // below doesn't work as returned class name is normally in project module scope
        
        let viewName = "SubstitutionView"
        guard let view = Bundle.main.loadNibNamed(viewName,
                                                  owner: self, options: nil)![0] as? UIView else {
            return
        }
        view.frame = CGRect.init(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        self.addSubview(view)
        view.anchorAllEdgesToSuperview()
    }
    
    //MARK:- ACTIONS
    /// Confirm button clicked
    /// - Parameter sender: UIButton
    @IBAction func confirmBtnPressed(_ sender: UIButton) {
        onSelection?(selectedPlayerRow)
        self.removeFromSuperview()
    }
    
    /// Close button clicked
    /// - Parameter sender: UIButton
    @IBAction func closeBtnPressed(_ sender: UIButton) {
        onSelection?(-1)
        self.removeFromSuperview()
    }
}

//MARK:- CollectionView DataSource
extension SubstitutionView: UICollectionViewDataSource {
    
    /// Number Of Rows In Section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.teamObj?.players.count ?? 0
    }
    
    /// Cell For Row At indexPath
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let identifier = "SubstitutionCVCell"
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! SubstitutionCVCell
        if let team = self.teamObj {
            /// Substitution Cell
            SubstitutionCell(cell: cell, team: team, indexPath: indexPath)
        } else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! SubstitutionCVCell
        }
        cell.backgroundColor = UIColor.clear
        return cell
    }
    
    ///Collection View Cell Setup
    /// User Cell
    /// - Parameters:
    ///   - cell: SubstitutionCVCell
    ///   - indexPath: IndexPath
    func SubstitutionCell(cell: SubstitutionCVCell,team: Team, indexPath: IndexPath) {
        let teamPlayerObj = team.players[indexPath.row]
        cell.userNameLbl.text = teamPlayerObj.name
        cell.userIdLbl.text = "# \(teamPlayerObj.number)"
        
        if self.selectedPlayerRow == indexPath.row {
            //cell.mainView.gradientViewBorder(color1: UIColor.white, color2: UIColor.white)
            cell.mainView.borderColor = UIColor.white
            cell.userIdLbl.textColor = Color.topSegmentBorderColor
            cell.userNameLbl.textColor = Color.topSegmentBorderColor
        } else {
            //cell.mainView.gradientViewBorder(color1: Color.userCellViewBorderGradientColor1, color2: Color.userCellViewBorderGradientColor2)
            cell.mainView.borderColor = Color.userCellViewBorderGradientColor1
            cell.userIdLbl.textColor = UIColor.white
            cell.userNameLbl.textColor = UIColor.white
        }
    }
}

//MARK:- CollectionView Delegate
extension SubstitutionView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        self.selectedPlayerRow = indexPath.row
        self.collectionView.reloadData()
    }
}

//MARK:- CollectionView Flow Layout Delegate
extension SubstitutionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 110, height: 90)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5.0
    }
}

