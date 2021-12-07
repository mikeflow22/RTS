//
//  FilesSectionModal.swift
//  Cudo
//
//  Created by softobiz-as on 03/03/21.
//

import Foundation
import UIKit

/// Row Modal for files listing
struct SubstitutionPlayerModal {
    
    /// User ID
    var userId: String
    
    /// User Name
    var userName: String
    
    /// Goals
    var numgOfgoals: Int
    
    /// initialize the modal
    /// - Parameters:
    ///   - userId: String
    ///   - userName: String
    ///   - goals: String
    init(userId:String ,userName: String, numgOfgoals: Int) {
        self.userId = userId
        self.userName = userName
        self.numgOfgoals = numgOfgoals
    }
    
}
