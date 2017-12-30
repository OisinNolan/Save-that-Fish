//
//  GameViewController.swift
//  Save that Fish
//
//  Created by Nuala O' Dea on 21/08/2015.
//  Copyright (c) 2015 oisinnolan. All rights reserved.
//

import UIKit
import SpriteKit
import GameKit
import GoogleMobileAds

extension SKNode {
    class func unarchiveFromFile(file : String) -> SKNode? {
        if let path = NSBundle.mainBundle().pathForResource(file, ofType: "sks") {
            var sceneData = NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe, error: nil)!
            var archiver = NSKeyedUnarchiver(forReadingWithData: sceneData)
            
            archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
            let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as! GameScene
            archiver.finishDecoding()
            return scene
        } else {
            return nil
        }
    }
}

class GameViewController: UIViewController, GKGameCenterControllerDelegate {

    let scene = GameScene.unarchiveFromFile("GameScene") as? GameScene
    
    @IBOutlet weak var dangerImage: UIImageView!
    @IBOutlet weak var coinImage: UIImageView!
    @IBOutlet weak var coinAmountLabel: UILabel!
    @IBOutlet weak var chestRewardLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highscoreLabel: UILabel!
    @IBOutlet weak var adBanner: GADBannerView!
    
    var shopVC: ShopViewController!
    var selectedChar = Int()
    var highscore = Int()
    
    var interstitial: GADInterstitial!
    
    override func viewDidLoad() {
        
        /*for key in NSUserDefaults.standardUserDefaults().dictionaryRepresentation().keys {
            NSUserDefaults.standardUserDefaults().removeObjectForKey(key.description)
        }*/
        
        super.viewDidLoad()

            // Configure the view.
            let skView = self.view as! SKView
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene!.scaleMode = .AspectFill
            scene!.viewController = self
            
            skView.presentScene(scene)
        
            scoreLabel.hidden = true
            highscore = NSUserDefaults.standardUserDefaults().integerForKey("highscore")
            highscoreLabel.text = "Highscore " + String(highscore)
        
            authenticateLocalPlayer()
        
            loadAds()
        
            self.interstitial = self.createAndLoadAd()
        
    }
    
    func loadAds() {
        
        adBanner.adUnitID = "ca-app-pub-7961711404023361/9799105939"
        
        adBanner.rootViewController = self
        
        var request: GADRequest = GADRequest()
        
        adBanner.loadRequest(request)
        
    }
    
    func checkChar() {
        
        selectedChar = NSUserDefaults.standardUserDefaults().integerForKey("selectedChar")
        NSUserDefaults.standardUserDefaults().synchronize()
        scene?.setTheChar()
        
    }
    
    func goToHowToPlay() {
    
        performSegueWithIdentifier("howToPlaySegue", sender: nil)
        
    }
    
    func goToShop() {
        
        performSegueWithIdentifier("shopSegue", sender: nil)
        
    }
    
    func fadeHighscore() {
    
        highscoreLabel.alpha = 1.0
        UILabel.animateWithDuration(1.5, animations: {
            self.highscoreLabel.alpha = 0.0
        }, completion: nil)
        
    }
    
    func authenticateLocalPlayer(){
        
        var localPlayer = GKLocalPlayer.localPlayer()
        
        localPlayer.authenticateHandler = {(viewController, error) -> Void in
            
            if (viewController != nil) {
                self.presentViewController(viewController, animated: true, completion: nil)
            }
                
            else {
                println((GKLocalPlayer.localPlayer().authenticated))
            }
        }
        
    }
    
    func saveHighscore(score:Int) {
        
        //check if user is signed in
        if GKLocalPlayer.localPlayer().authenticated {
            
            var scoreReporter = GKScore(leaderboardIdentifier: "savethatfishleaderboardoisinnolan") //leaderboard id here
            
            scoreReporter.value = Int64(score) //score variable here (same as above)
            
            var scoreArray: [GKScore] = [scoreReporter]
            
            GKScore.reportScores(scoreArray, withCompletionHandler: {(error : NSError!) -> Void in
                if error != nil {
                    println("error")
                }
            })
            
        }
        
    }
    
    func saveCoins(coins:Int) {
        
        //check if user is signed in
        if GKLocalPlayer.localPlayer().authenticated {
            
            var scoreReporter = GKScore(leaderboardIdentifier: "seavethatfishcoinleaderboardoisinnolan") //leaderboard id here
            
            scoreReporter.value = Int64(coins) //score variable here (same as above)
            
            var scoreArray: [GKScore] = [scoreReporter]
            
            GKScore.reportScores(scoreArray, withCompletionHandler: {(error : NSError!) -> Void in
                if error != nil {
                    println("error")
                }
            })
            
        }
        
    }
    
    func showLeader() {
        NSLog("showleader")
        var vc = self
        var gc = GKGameCenterViewController()
        gc.gameCenterDelegate = self
        vc.presentViewController(gc, animated: true, completion: nil)
    }
    
    func gameCenterViewControllerDidFinish(gameCenterViewController: GKGameCenterViewController!) {
        
        gameCenterViewController.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func createAndLoadAd() -> GADInterstitial {
        
        var ad = GADInterstitial(adUnitID: "ca-app-pub-7961711404023361/3752572338")
        var request = GADRequest()
        ad.loadRequest(request)
        return ad
        
    }

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> Int {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return Int(UIInterfaceOrientationMask.AllButUpsideDown.rawValue)
        } else {
            return Int(UIInterfaceOrientationMask.All.rawValue)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func delay(delayInSeconds:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delayInSeconds * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
}
