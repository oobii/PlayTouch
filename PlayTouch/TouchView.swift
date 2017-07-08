//
//  TouchView.swift
//  PlayTouch
//
//  Created by martynov on 2017-06-30.
//  Copyright © 2017 martynov. All rights reserved.
//

import UIKit

class TouchView: UIView {

    var scale: CGFloat = 1.0 { didSet {setNeedsDisplay()}}
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    // we are using computed vars becaue we need to use bound which is FaceView own property, inhereted from UIView
    
    fileprivate var faceRadius: CGFloat {
        get {
            return min(bounds.size.width, bounds.size.height) / 2 * scale
        }
    }
    
    // we can actually skip the "get"
    fileprivate var faceCenter: CGPoint {
        return CGPoint(x: bounds.midX, y: bounds.midY)
    }

    //Drawing in the View!
     override func draw(_ rect: CGRect) {
        UIColor.blue.set()
        let path = UIBezierPath(arcCenter: faceCenter, radius: faceRadius, startAngle: 0.0, endAngle: 2*CGFloat(M_PI), clockwise: true)
        path.lineWidth = 5.0
        path.stroke()
        
    }
}

