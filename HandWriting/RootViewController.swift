//
//  RootViewController.swift
//  HandWriting
//
//  Created by Aurélien WOLFERT on 20/06/2016.
//  Copyright © 2016 snake788. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class RootViewController: UIViewController {
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    @IBOutlet weak var labelWelcome: UILabel!
    @IBOutlet weak var buttonContinue: UIButton!
    
    @IBOutlet weak var labelWelcomeTopConstraint: NSLayoutConstraint!
    
    var player: AVPlayer!
    var playerQueue: AVQueuePlayer!
    var playerLayer: AVPlayerLayer!
    var isFirstLayout: Bool = true
    
    // MARK: - Controller lifecyle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupVideoPlayer()
        self.updateUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if self.isFirstLayout {
            self.isFirstLayout = false
            
            self.updateConstraints()
        }
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.videoPlayerShouldBePlayed()
        self.animateSubviews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - UI -
    
    private func updateUI() {
        self.visualEffectView.alpha = 0.5
        
        self.updateLabels()
        self.updateButtons()
    }
    
    private func updateConstraints() {
        self.labelWelcome.transform = CGAffineTransformMakeScale(0.1, 0.1)
        self.labelWelcomeTopConstraint.constant += self.view.bounds.size.height
    }
    
    private func updateLabels() {
        self.labelWelcome.text = NSLocalizedString("WALKTHROUGH_LABEL_WELCOME", comment: "")
    }
    
    private func updateButtons() {
        self.buttonContinue.addCornerRadius(6.0)
        self.buttonContinue.setTitle(NSLocalizedString("WALKTHROUGH_BUTTON_CONTINUE", comment: ""), forState: UIControlState.Normal)
        self.buttonContinue.backgroundColor = UIColor.HWBlack1()
        self.buttonContinue.alpha = 0.0
    }
    
    private func animateSubviews() {
        self.labelWelcome.transform = CGAffineTransformMakeScale(1.0, 1.0)
        self.labelWelcomeTopConstraint.constant -= self.view.bounds.size.height
        
        UIView.animateWithDuration(1.5, delay: 0.0, options: UIViewAnimationOptions.TransitionNone, animations: {
            self.view.layoutIfNeeded()
        }) { (isCompleted) in
            UIView.animateWithDuration(2.5, animations: {
                self.buttonContinue.alpha = 1.0
            })
        }
    }
    
    // MARK: - Video player -
    
    /**
     Setup a playerLayer responsible for read a video
     */
    private func setupVideoPlayer() {
        let playerItem = ResourceHelper.getPlayerItemForFile(Constants.Videos.HANDWRITING_WALKTHROUGH)
        
        self.playerQueue = AVQueuePlayer(items: [playerItem])
        self.playerQueue.insertItem(ResourceHelper.getPlayerItemForFile(Constants.Videos.HANDWRITING_WALKTHROUGH), afterItem: nil)
        self.player = self.playerQueue
        self.playerLayer = AVPlayerLayer(player: self.player)
        self.playerLayer.frame = self.view.bounds
        self.playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        self.playerLayer.needsDisplayOnBoundsChange = true
        
        self.view.layer.insertSublayer(self.playerLayer, atIndex: 0)
        
        NSNotificationCenter.defaultCenter().addObserverForName(AVPlayerItemDidPlayToEndTimeNotification, object: nil, queue: nil) { (notification) -> Void in
            let playerItem = ResourceHelper.getPlayerItemForFile(Constants.Videos.HANDWRITING_WALKTHROUGH)
            
            self.playerQueue.insertItem(playerItem, afterItem: nil)
            
            if let finalCurrentItem = self.player.currentItem {
                self.playerQueue.removeItem(finalCurrentItem)
            }
        }
    }
    
    private func videoPlayerShouldBePlayed() {
        self.player.play()
    }
    
    private func videoPlayerShouldBeRemoved() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: AVPlayerItemDidPlayToEndTimeNotification, object: nil)
        
        self.player.pause()
        self.player.replaceCurrentItemWithPlayerItem(nil)
    }
    
    private func releaseVideoPlayer() {
        self.videoPlayerShouldBeRemoved()
        self.playerQueue.removeAllItems()
        self.playerLayer.removeFromSuperlayer()
        self.player = nil
        self.playerLayer = nil
        self.playerQueue = nil
    }
    
    // MARK: - Button action -
    
    @IBAction func buttonContinueTouched(sender: UIButton) {
        NSUserDefaults.standardUserDefaults().setBool(false, forKey: Constants.ApplicationKeys.FIRST_LAUNCH)
        NSUserDefaults.standardUserDefaults().synchronize()
        
        self.releaseVideoPlayer()
        
        self.performSegueWithIdentifier("tabBarSegue", sender: self)
    }
}
