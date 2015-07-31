//
//  DSSanmakuAttribute.swift
//  DSDanmakuPlayer
//
//  Created by liaojinhua on 15/7/30.
//  Copyright (c) 2015年 Daisy. All rights reserved.
//

import UIKit

enum DSDanmakuPosition : Int {
    
    case Normal
    case Middle
    case FixedTop
    case FixedBotton
}

class DSSanmakuAttribute: NSObject {
    
    var color:UIColor = UIColor.whiteColor()
    var font:UIFont = UIFont.systemFontOfSize(14)
    var delayInterval:NSTimeInterval = NSTimeInterval(0.0)
    var position:DSDanmakuPosition = .Normal
    
    override init() {
        super.init()
    }
    
    convenience init(color:UIColor, font:UIFont, delay:NSTimeInterval, position:DSDanmakuPosition) {
        self.init()
        self.color = color
        self.font = font
        self.delayInterval = delay
        self.position = position
    }
    
    convenience init(color:UIColor, font:UIFont) {
        self.init(color:color, font:font, delay:NSTimeInterval(0.0), position:.Normal)
    }
    
    
}
