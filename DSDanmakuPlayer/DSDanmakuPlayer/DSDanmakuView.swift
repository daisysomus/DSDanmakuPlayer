//
//  DSDanmakuView.swift
//  DSDanmakuPlayer
//
//  Created by liaojinhua on 15/7/15.
//  Copyright (c) 2015年 Daisy. All rights reserved.
//

import UIKit

class DSDanmakuView: UIView {
    
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
        
        var point = self.countAvailablePositionForDanmaku(danmakuLabel)
        println("point \(point) \(text)")
        danmakuLabel.setPosition(point)
        
        
        self.addSubview(danmakuLabel)
        self.playDanmaku(danmakuLabel)
        self.addMovingDanmaku(danmakuLabel)
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
            }
        })
    }
    
    func countAvailablePositionForDanmaku(danmaku:DSDanmakuLabel) -> CGPoint {
        var x = CGRectGetWidth(self.frame)
        var y = CGFloat(0.0)
        var rect = CGRectMake(x, y, CGRectGetWidth(danmaku.frame), CGRectGetHeight(danmaku.frame))
        var found = false
        var intersect:DSDanmakuLabel?
        var intersectY = CGFloat(0.0)
        do {
            if let value = intersect {
                rect.origin.x = CGRectGetMaxX(value.layer.presentationLayer().frame) + 50
                rect.origin.y = intersectY
                intersect = nil
            }
            for existDanmaku:DSDanmakuLabel in movingDanmaku {
                var compareRect = existDanmaku.layer.presentationLayer().frame
                if (CGRectIntersectsRect(rect, compareRect)) {
                    if intersect == nil {
                        intersect = existDanmaku
                        intersectY = CGRectGetMaxY(existDanmaku.frame)
                        
                    }
                    rect.origin.y += CGRectGetHeight(rect)
                }
            }
            
        } while (intersect != nil)
        
        return rect.origin
    }
    
    func addMovingDanmaku(danmaku:DSDanmakuLabel) {
        var index:Int
        for index = 0; index < movingDanmaku.count; index++ {
            var existDanmaku = movingDanmaku[index]
            if (CGRectGetMinY(existDanmaku.frame) > CGRectGetMinY(danmaku.frame)) {
                movingDanmaku.insert(danmaku, atIndex: index)
                return
            }
        }
        
        movingDanmaku.append(danmaku)
    }

}
