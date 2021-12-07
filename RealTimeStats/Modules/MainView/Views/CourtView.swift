//
//  CourtView.swift
//  CourtView
//
//  Created by Frank LaRosa on 12/3/21.
//

import UIKit

struct CourtHit {
    var x: CGFloat
    var y: CGFloat
    var points: Int
}

protocol CourtDelegate: AnyObject {
    func hitRegistered(hit: CourtHit)
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
        let gr: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapResponder(_:)))
        self.addGestureRecognizer(gr);
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

    // Respond to taps by calling the delegate
    @IBAction func tapResponder(_ sender: UIGestureRecognizer) {
        // Figure out where they tapped as x,y coordinates
        let point: CGPoint = sender.location(in: self)
        
        // Figure out if they tapped in a 2-point or 3-point area
        let alpha = alphaFromPoint(point: point, view: maskHitView)
        let points = alpha < 128 ? 3 : 2
        
        // Figure out the x and y coordinates as a percentage of the court width and height
        let x = CGFloat(point.x) / self.frame.size.width
        let y = CGFloat(point.y) / self.frame.size.height
        
        // Send the hit event to the delegate
        let hit = CourtHit(x: x, y: y, points: points)
        delegate?.hitRegistered(hit: hit)
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
