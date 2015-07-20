//
//  ViewController.swift
//  DSDanmakuPlayer
//
//  Created by liaojinhua on 15/7/15.
//  Copyright (c) 2015年 Daisy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var timer:NSTimer?
    
    var danmakuView: DSDanmakuView?
    var danmakuTest = ["这真是一个好时代啊","来自地狱的声音","还大闹天宫呢，人家早就娶亲了","嘿嘿","我顶你个肺", "我是一只小小小小鸟","你是猴子派来的救兵吗","你算个啥子呦","这也太扯了吧"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        danmakuView = DSDanmakuView(frame: CGRectMake(0, 20, CGRectGetWidth(self.view.frame), 200))
        self.view.addSubview(danmakuView!)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.startTimer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startTimer() {
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "timeOUt:", userInfo: nil, repeats: true)
    }
    
    func timeOUt(timer:NSTimer) {
        var index = random() % danmakuTest.count
        var red = CGFloat(random()%255)/255.0
        var green = CGFloat(random()%255)/255.0
        var blue = CGFloat(random()%255)/255.0
        var fontSize = CGFloat(random()%10 + 14)
        danmakuView!.addDanmaku(danmakuTest[index], font:UIFont.systemFontOfSize(fontSize), color:UIColor(red: red, green: green, blue: blue, alpha: 1.0))
    }
    @IBAction func pauseAction(sender: AnyObject) {
        danmakuView!.pause()
        timer?.invalidate()
    }
    
    
    
    @IBAction func startAction(sender: AnyObject) {
        danmakuView!.restartPlay()
        self.startTimer()
    }
}

