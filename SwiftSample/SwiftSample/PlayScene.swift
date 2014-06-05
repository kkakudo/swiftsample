//
//  PlayScene.swift
//  SwiftSample
//
//  Created by kkakudo on 2014/06/04.
//  Copyright (c) 2014年 Members Co.,Ltd. All rights reserved.
//

import UIKit
import SpriteKit
import CoreMotion

func skRand(low:CGFloat, high:CGFloat) -> CGFloat {
    return CGFloat(arc4random()) / CGFloat(RAND_MAX) * (high - low) + low
}

class PlayScene: SKScene, SKPhysicsContactDelegate {
    
    var motionManager:CMMotionManager
    
    init(size:CGSize) {
        self.motionManager = CMMotionManager()
        self.motionManager.deviceMotionUpdateInterval = 0.025
        self.motionManager.startDeviceMotionUpdates()

        super.init(size:size)
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect:self.frame)
        
        self.becomeFirstResponder()
    }
    
    deinit {
        self.motionManager.stopDeviceMotionUpdates()
    }
    
    func newBall() -> SKNode! {
        let ball:SKShapeNode = SKShapeNode()
        let path:CGMutablePathRef = CGPathCreateMutable()
        let r:CGFloat = skRand(5, 30)
        CGPathAddArc(path, nil, 0, 0, r, 0, CGFloat(M_PI * 2), true)
        ball.path = path
        ball.fillColor = UIColor(red:skRand(0, 1.0), green:skRand(0, 1.0), blue:skRand(0, 1.0), alpha:skRand(0.7, 1.0))
        ball.strokeColor = SKColor.clearColor()
        ball.position = CGPointMake(CGRectGetMidX(self.frame), self.frame.size.height - r)
        ball.physicsBody = SKPhysicsBody(circleOfRadius:r)
        return ball
    }
    
    func resetBall() {
        self.removeAllChildren()
    }
    
    override func touchesBegan(touches: NSSet!, withEvent event: UIEvent!) {
        let touch:UITouch = touches.anyObject() as UITouch
        let location:CGPoint = touch.locationInNode(self)
        
        let nodeAtPoint:SKNode = self.nodeAtPoint(location)
        if  nodeAtPoint != self {
            nodeAtPoint.removeFromParent()
        }
        else {
            let ball:SKNode = self.newBall()
            ball.position = location
            self.addChild(ball)
        }
    }
    
    override func update(currentTime:CFTimeInterval) {
        if self.motionManager.deviceMotion != nil {
            let gravity:CMAcceleration = self.motionManager.deviceMotion.gravity
            self.physicsWorld.gravity = CGVectorMake(CGFloat(gravity.x*4), CGFloat(gravity.y*4))
        }
    }
    
}
