//
//  Extensions.swift
//  RealTimeStats
//
//  Created by Debbi Chandel on 09/11/21.
//

import Foundation
import UIKit


//MARK: Device Constraints
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

//MARK: View Controller Extension
extension UIViewController {
    
    func showCustomAlert(view: UIViewController, title: String, message: String, completion: @escaping( _ choice: Bool)  -> Void) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let noAction = UIAlertAction(title: "No", style: .destructive, handler: { action in
                completion(false)
            })
            let yesAction = UIAlertAction(title: "Yes", style: .default, handler: { action in
                completion(true)
            })
            alert.addAction(noAction)
            alert.addAction(yesAction)
            DispatchQueue.main.async(execute: {
                view.present(alert, animated: true)
            })
        }
}
    

