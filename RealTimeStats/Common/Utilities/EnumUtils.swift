//
//  Extensions.swift
//  RealTimeStats
//
//  Created by Debbi Chandel on 09/11/21.
//

import Foundation
import UIKit


//MARK:- Device Constraints
///Extented further in EnumUtil.swift class
enum Screen {}

//MARK:- Device Constraints
extension Screen {
    /// Main Screen
    static let main = UIScreen.main
    /// Screen Width
    static let width = UIScreen.main.bounds.size.width
    ///Screen Height
    static let height = UIScreen.main.bounds.size.height
    /// Screen center width
    static let centerW = Screen.width/2
    /// Screen center height
    static let centerH = Screen.height/2
    /// UserInterfaceIdiom
    static let deviceIdiom = main.traitCollection.userInterfaceIdiom
    /// Is device Ipad?
    static let isIPAD: Bool = deviceIdiom == UIUserInterfaceIdiom.pad ? true : false
}
