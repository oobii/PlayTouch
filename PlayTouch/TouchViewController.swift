//
//  ViewController.swift
//  PlayTouch
//
//  Created by martynov on 2017-06-30.
//  Copyright © 2017 martynov. All rights reserved.
//

import UIKit

class TouchViewController: UIViewController {
    
    var tapRec: UITapGestureRecognizer?
    var doubleTapRec: UITapGestureRecognizer?
    
    @IBOutlet weak var outMsg: UILabel!
    
    @IBOutlet var edgePanLeft: UIScreenEdgePanGestureRecognizer!
    
    @IBOutlet weak var myTouchView: TouchView! {
        
        didSet {
            
            //when we add gesture recognizers via Storyboard we use viewDidLoad()
            
            // The pan works, it just confuses swipes
            //let panRec = UIPanGestureRecognizer(target: self, action: #selector(self.pan))
            //myTouchView.addGestureRecognizer(panRec)
            
            let pinchRec = UIPinchGestureRecognizer(target: self, action: #selector(self.pinch))
            myTouchView.addGestureRecognizer(pinchRec)
            
            // for swiping we do create separate recognizer but one func to handle all directions
            // tested
            
            let swipeRecRight = UISwipeGestureRecognizer(target: self, action: #selector(self.swipe))
            //swipeRec.numberOfTouchesRequired = 1
            swipeRecRight.direction = UISwipeGestureRecognizerDirection.right
            myTouchView.addGestureRecognizer(swipeRecRight)
            
            let swipeRecLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.swipe))
            //swipeRec.numberOfTouchesRequired = 1
            swipeRecRight.direction = UISwipeGestureRecognizerDirection.left
            myTouchView.addGestureRecognizer(swipeRecLeft)
            
            
            
            doubleTapRec = UITapGestureRecognizer(target: self, action: #selector(self.doubleTap))
            doubleTapRec?.numberOfTapsRequired = 2
            doubleTapRec?.numberOfTouchesRequired = 1
            myTouchView.addGestureRecognizer(doubleTapRec!)
            
            tapRec = UITapGestureRecognizer(target: self, action: #selector(self.oneTap))
            tapRec?.numberOfTapsRequired = 1
            tapRec?.numberOfTouchesRequired = 1
            // this introduces a delay in detecting one touch
            tapRec?.require(toFail: doubleTapRec!)
            myTouchView.addGestureRecognizer(tapRec!)
            
            //let rotationRec = UIRotationGestureRecognizer
            
        }
        
    }
    
    
    // we can use one function or two separate functions
    func taps(recognz: UITapGestureRecognizer) {
        
        let touchPoint = recognz.location(in: myTouchView!)
        
        switch recognz {
        case self.tapRec!: print("One tap detected at x=\(touchPoint.x) y=\(touchPoint.y)")
        case self.doubleTapRec!: print("Double tap detected at x=\(touchPoint.x) y=\(touchPoint.y) ")
        default: break
        }
        
        //print("Double tap detected")
        
    }
    
    // using two funcs
    func oneTap(recognz: UITapGestureRecognizer) {
        
        let touchPoint = recognz.location(in: myTouchView!)
        let text = "One tap detected at x=\(touchPoint.x) y=\(touchPoint.y)"
        print(text)
        outMsg.text = text
        myTouchView.scale = 0.5
    }
    
    func doubleTap(recognz: UITapGestureRecognizer) {
        
        let touchPoint = recognz.location(in: myTouchView!)
        let text = "Double tap detected at x=\(touchPoint.x) y=\(touchPoint.y)"
        print(text)
        outMsg.text = text
        myTouchView.scale = 1
    }
    
    
    func swipe(recognz: UISwipeGestureRecognizer) {
        
        switch recognz.direction   {
        case UISwipeGestureRecognizerDirection.right: print("Swiped Right")
        outMsg.text = "Swiped Right"
        case UISwipeGestureRecognizerDirection.left: print("Swiped Left")
        outMsg.text = "Swiped Left"
        default: break
        }
        
    }
    
    // not used , using one general swipe func
    func swipeLeft(recognz: UISwipeGestureRecognizer) {
        
        print("Swiped Left")
    }
    
    func swipeRight(recognz: UISwipeGestureRecognizer) {
        
        print("Swiped Right")
    }
    
    func pinch(recognz: UIPinchGestureRecognizer) {
        
        
        switch recognz.state {
        case .changed, .ended:
            myTouchView.scale *= recognz.scale
            let text = "Pinch detected, scale=\(recognz.scale)"
            print(text)
            outMsg.text = text
            recognz.scale = 1.0
        default:
            break
        }
        
        
    }
    
    // not used cause pan recogn is commented out, working with swipes
    func pan(recognz: UIPanGestureRecognizer) {
        
        switch recognz.state {
        case .changed: fallthrough
        case .ended:
            let translation = recognz.translation(in: myTouchView)
            print("translation:  x=\(translation.x) y=\(translation.y)")
            
            
        default: break
        }
        print("detected pan")
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

