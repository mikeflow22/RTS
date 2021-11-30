//
//  CreateRulesViewController.swift
//  RealTimeStats
//
//  Created by Michael Flowers on 11/22/21.
//

import UIKit

class CreateRulesViewController: UIViewController {

    var tc: TournamentController? {
        didSet {
            print("TC was set in CreateRulesVC")
        }
    }
    
    @IBOutlet weak var halvesTF: UITextField!
    @IBOutlet weak var timePerHalfTF: UITextField!
    @IBOutlet weak var foulLimitTF: UITextField!
    @IBOutlet weak var bonusLimitTF: UITextField!
    @IBOutlet weak var doubleBonusLimitTF: UITextField!
    @IBOutlet weak var timeoutsTF: UITextField!
    
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        guard let halves = halvesTF.convertToInt() else {
            print("halves could not convert to int")
            return
        }
        guard let timePerHalfInt = timePerHalfTF.convertToInt() else {
            print("timer per half text field error")
            return
        }
        
        let timePerHalfDouble = Double(timePerHalfInt)
        print("this is the double: \(timePerHalfDouble)")
        
        guard let foulLimit = foulLimitTF.convertToInt() else {
            print("foul limit could not convert to int")
            return
        }
        
        guard let bonusLimit = bonusLimitTF.convertToInt() else {
            print("bonus limit could not convert to int")
            return
        }
        
        guard let doubleBonusLimit = doubleBonusLimitTF.convertToInt() else {
            print("double bonus limit could not convert to int")
            return
        }
        
        guard let timeouts = timeoutsTF.convertToInt() else {
            print("timeouts could not convert to int")
            return
        }
        
        let rules = Rule(halves: halves, timePerHalf: timePerHalfDouble, foulLimit: foulLimit, bonusLimit: bonusLimit, doubleBonusLimit: doubleBonusLimit, timeouts: timeouts)
        
        guard let tc = self.tc else {
            print("current tournament not set")
            return
        }
        
        tc.addRulesTo(rules)
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UITextField {
    func convertToInt() -> Int? {
        guard let string = self.text, !string.isEmpty, let stringToInt = Int(string) else {
            print("could not convert string to int")
            return nil
        }
        return stringToInt
    }
}
extension UILabel {
    func convertToDouble() -> Double? {
        guard let string = self.text, !string.isEmpty, let stringToDouble = Double(string) else {
            print("could not convert string to Double")
            return nil
        }
        return stringToDouble
    }
}
