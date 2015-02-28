//
//  Loader.swift
//  
//
//  Created by Jo Albright on 2/27/15.
//
//

import UIKit

class Loader: UIView {
    
    var circleColor = UIColor.blackColor()
    
    // s = size, m = max, d = direction, x = offsetX, y = offsetY, a = alpha
    
    var circles: [[String:CGFloat]] = [
    
        ["s":0.5,"m":1.0,"d":0.013,"x":+0.0,"y":+0.0,"a":0.8],
        ["s":0.2,"m":0.4,"d":0.011,"x":+0.4,"y":-0.4,"a":0.6],
        ["s":0.2,"m":0.4,"d":0.012,"x":-0.4,"y":+0.3,"a":0.5],
        ["s":0.1,"m":0.3,"d":0.010,"x":+0.4,"y":+0.3,"a":0.3],
        ["s":0.1,"m":0.2,"d":0.008,"x":-0.5,"y":-0.3,"a":0.2]
    
    ]
    
    var degree: CGFloat = 0.0
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        backgroundColor = UIColor.clearColor()
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        
        // run a frame animation
        
        let center = CGPointMake(CGRectGetMidX(rect),CGRectGetMidY(rect))
        
        var half = rect.width > rect.height ? rect.height / 2 : rect.width / 2
        
        // Drawing code
        
        var context = UIGraphicsGetCurrentContext()
        
        for (c,circle) in enumerate(circles) {
            
            circleColor.colorWithAlphaComponent(circle["a"]!).set()
            
            let size = half * circle["s"]!
            let x = center.x - (size / 2) + (circle["x"]! * half)
            let y = center.y - (size / 2) + (circle["y"]! * half)
            
            let circleRect = CGRectMake(x, y, size, size)
            
            CGContextFillEllipseInRect(context, circleRect)
            
        }
        
    }
    
    var timer: NSTimer?
    
    func runLoop() {
        
        for (c,v) in enumerate(circles) {
            
            var circle = v
            
            var direction = circle["d"]!
            let size = circle["s"]!
            let max = circle["m"]!
            
            if size < 0 || size > max { direction *= -1 }
            
            circle["d"] = direction
            circle["s"] = size + direction
            
            circles[c] = circle
            
        }
        
        setNeedsDisplay()
        
//        degree = degree > 360.0 ? 0.0 : degree + 0.2        
//        transform = CGAffineTransformMakeRotation(degree * CGFloat(M_PI) / 180.0)
        
    }
    
    func startAnimating() {
        
        if timer == nil {
            
            timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: "runLoop", userInfo: nil, repeats: true)
            
        }
        
    }
    
    func stopAnimating() {
        
        timer?.invalidate()
        timer = nil
        
    }

}





