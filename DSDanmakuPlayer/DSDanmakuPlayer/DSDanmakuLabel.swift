//
//  DSDanmakuLabel.swift
//  DSDanmakuPlayer
//
//  Created by liaojinhua on 15/7/15.
//  Copyright (c) 2015年 Daisy. All rights reserved.
//

import UIKit

class DSDanmakuLabel: UILabel {
    
    var remainTime = NSTimeInterval(DSDanmakuAnimationInterval)
    var originalXPosition = CGFloat(0.0)

    init(danmakuText:String, font:UIFont, color:UIColor) {
        super.init(frame:CGRectZero)
        self.text = danmakuText
        self.font = font
        self.textColor = color
        self.configLabel()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configLabel() {
        
        self.sizeToFit()
    }
    
    func setPosition(position:CGPoint) {
        self.frame = CGRectMake(position.x, position.y, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))
        originalXPosition = position.x
    }
    
    func calculateReaminTime(standWidth:Double) {
        remainTime = (NSTimeInterval)(CGRectGetMaxX(self.frame) + CGRectGetWidth(self.frame)) * remainTime/standWidth
    }

    func startPlay(complete:(Bool) -> Void) {
        UIView.animateWithDuration(remainTime, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.frame = CGRectMake(-CGRectGetWidth(self.frame), CGRectGetMinY(self.frame), CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))
        }, completion: complete)
    }
    
    func pauseAnimation() {
        self.frame = self.layer.presentationLayer().frame
        var ratio = (NSTimeInterval)((CGRectGetMinX(self.frame) + CGRectGetWidth(self.frame))/(originalXPosition + CGRectGetWidth(self.frame)))
        remainTime = remainTime * ratio
        self.layer.removeAllAnimations()
    }
}
