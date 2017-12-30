//
//  IntroViewController.swift
//  Save that Fish
//
//  Created by Nuala O' Dea on 06/09/2015.
//  Copyright (c) 2015 oisinnolan. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController {

    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var nolan: UILabel!
    
     let scene = GameScene.unarchiveFromFile("GameScene") as? GameScene
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        nextScene()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func nextScene() {
        
        delay(2) {
            self.performSegueWithIdentifier("segueToGame", sender: nil)
        }
        
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
