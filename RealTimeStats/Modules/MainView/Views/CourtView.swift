//
//  CourtView.swift
//  CourtView
//
//  Created by Frank LaRosa on 12/3/21.
//

import UIKit

//CourtHit is the new Shot
struct Shot {
    var x: CGFloat
    var y: CGFloat
    var points: Int
    var success: Bool
    var stats: Stats
}

protocol CourtDelegate: AnyObject {
    func hitRegistered(hit: Shot)
}

class CourtView: UIImageView
{
    // Set this delegate in order to receive hit events
    public weak var delegate: CourtDelegate?
    
    private var maskHitView: UIImageView!

    // Sets up this view to contain the court image, sets up the hidden maskHitView, and sets up the tap gesture recognizer.
    private func setUpViews() {
        self.image = UIImage(named: "court")
        self.contentMode = .scaleAspectFit
        maskHitView = UIImageView()
        maskHitView.image = UIImage(named: "mask")
        maskHitView.contentMode = .scaleAspectFit
        
        let doubleTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(madeTap(_:)))
        doubleTap.numberOfTapsRequired = 2
        
        let oneTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(missedTap(_:)))
        oneTap.require(toFail: doubleTap)
        self.addGestureRecognizer(doubleTap)
        self.addGestureRecognizer(oneTap);
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpViews()
    }

    // layoutSubviews will get called whenever this view changes size. When that happens, we need to resize the maskHitView to match.
    override func layoutSubviews() {
        super.layoutSubviews()
        maskHitView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
    }
    func figureOutStats(points: Int, success: Bool) -> Stats {
        var stats: Stats!
        
        if points == 3 && success {
            stats = .madeA3pt
            print("double tap was recorded. shot was worth: \(points)pts")
        } else if points == 3 && success == false {
            stats = .missedA3pt
            print("single tap was recorded. shot was worth: \(points)pts")
        } else if points == 2 && success {
            stats = .madeA2pt
            print("double tap was recorded. shot was worth: \(points)pts")
        } else if points == 2 && success == false {
            stats = .missedA2pt
            print("single tap was recorded. shot was worth: \(points)pts")
        }
        return stats
    }
    func whereDidTheyTap(_ point: CGPoint, success: Bool){
        // Figure out if they tapped in a 2-point or 3-point area
        let alpha = alphaFromPoint(point: point, view: maskHitView)
        let points = alpha < 128 ? 3 : 2
        let stats = figureOutStats(points: points, success: success)
        
        // Figure out the x and y coordinates as a percentage of the court width and height
        let x = CGFloat(point.x) / self.frame.size.width
        let y = CGFloat(point.y) / self.frame.size.height
        
        // Send the hit event to the delegate
        let shot = Shot(x: x, y: y, points: points, success: success, stats: stats)
        delegate?.hitRegistered(hit: shot)
    }
    
    @objc func madeTap(_ sender: UIGestureRecognizer) {
        whereDidTheyTap(sender.location(in: self), success: true)
    }

    // Respond to taps by calling the delegate
    @IBAction func missedTap(_ sender: UIGestureRecognizer) {
        whereDidTheyTap(sender.location(in: self), success: false)
    }

    
    // This function figures out the alpha value (transparency) of the pixel under the given point in a view.
    // This allows us to detect when the hit area occurs in a transparent area of a view, such as in the corner of a curved area.
    func alphaFromPoint(point: CGPoint, view: UIView) -> CGFloat {
        var pixel: [UInt8] = [0, 0, 0, 0]
        let colourSpace = CGColorSpaceCreateDeviceRGB()
        let alphaInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let context = CGContext(data: &pixel, width: 1, height: 1, bitsPerComponent: 8, bytesPerRow: 4, space: colourSpace, bitmapInfo: alphaInfo.rawValue)

        context?.translateBy(x: -point.x, y: -point.y)
        view.layer.render(in: context!)

        let floatAlpha = CGFloat(pixel[3])
        return floatAlpha
    }

}
