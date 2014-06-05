//
//  ViewController.swift
//  SwiftSample
//
//  Created by kkakudo on 2014/06/04.
//  Copyright (c) 2014年 Members Co.,Ltd. All rights reserved.
//

import UIKit
import SpriteKit

class ViewController: UIViewController {
    var skView:SKView?

    override func loadView() {
        self.skView = SKView(frame: UIScreen.mainScreen().bounds)
        self.view = skView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let skView: SKView = self.view as SKView
        skView.showsDrawCount = true
        skView.showsNodeCount = true
        skView.showsFPS = true
        
        let scene: PlayScene = PlayScene(size: self.view.bounds.size)
        skView.presentScene(scene)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true;
    }
    
    override func canBecomeFirstResponder() -> Bool {
        return true;
    }
    
    override func motionEnded(motion:UIEventSubtype, withEvent event: UIEvent!) {
        if (motion == UIEventSubtype.MotionShake) {
            let playScene:PlayScene = self.skView!.scene as PlayScene
            playScene.resetBall()
        }
    }
}

