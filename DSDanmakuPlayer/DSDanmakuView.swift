//
//  DSDanmakuView.swift
//  DSDanmakuPlayer
//
//  Created by liaojinhua on 15/7/15.
//  Copyright (c) 2015年 Daisy. All rights reserved.
//

import UIKit

class DSDanmakuView: UIView {
    
    var yPosition = CGFloat(0.0)
    var movingDanmaku = [DSDanmakuLabel]()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.clipsToBounds = true
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func addDanmaku(text:String, font:UIFont, color:UIColor) {
        var danmakuLabel = DSDanmakuLabel(danmakuText:text, font:font, color:color)
        if (yPosition + CGRectGetHeight(danmakuLabel.frame) > CGRectGetHeight(self.frame)) {
            yPosition = CGFloat(0.0)
        }
        println("yPosition \(yPosition)")
        danmakuLabel.setPosition(CGPointMake(CGRectGetWidth(self.frame), yPosition))
        yPosition += CGRectGetHeight(danmakuLabel.frame)
        
        self.addSubview(danmakuLabel)
        self.playDanmaku(danmakuLabel)
        movingDanmaku.append(danmakuLabel)
    }
    
    func addDanmakus(textsArray:[String], font:UIFont, color:UIColor) {
        for text in textsArray {
            self.addDanmaku(text, font: font, color: color)
        }
    }
    
    func pause() {
        for danmaku:DSDanmakuLabel in movingDanmaku {
            danmaku.pauseAnimation()
        }
    }
    
    func restartPlay() {
        for danmaku:DSDanmakuLabel in movingDanmaku {
            self.playDanmaku(danmaku)
        }
    }
    
    func playDanmaku(danmaku:DSDanmakuLabel) {
        weak var wself = self
        danmaku.startPlay({(complete:Bool) -> Void in
            if (complete) {
                danmaku.removeFromSuperview()
                if (wself?.yPosition > CGRectGetMinY(danmaku.frame)) {
                    wself?.yPosition = CGRectGetMinY(danmaku.frame)
                }
            }
        })
    }

}
