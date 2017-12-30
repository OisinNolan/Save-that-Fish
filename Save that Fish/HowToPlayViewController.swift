//
//  HowToPlayViewController.swift
//  Save that Fish
//
//  Created by Nuala O' Dea on 12/09/2015.
//  Copyright (c) 2015 oisinnolan. All rights reserved.
//

import UIKit

class HowToPlayViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let vc1 = HowToPlayScreen1ViewController(nibName: "HowToPlayScreen1ViewController", bundle: nil)
        
        self.addChildViewController(vc1)
        self.scrollView.addSubview(vc1.view)
        vc1.didMoveToParentViewController(self)
        
        let vc2 = HowToPlayScreen2ViewController(nibName: "HowToPlayScreen2ViewController", bundle: nil)
        
        var frame2 = vc2.view.frame
        frame2.origin.x = self.view.frame.size.width
        vc2.view.frame = frame2
        
        self.addChildViewController(vc2)
        self.scrollView.addSubview(vc2.view)
        vc2.didMoveToParentViewController(self)
        
        let vc3 = HowToPlayScreen3ViewController(nibName: "HowToPlayScreen3ViewController", bundle: nil)
        
        var frame3 = vc3.view.frame
        frame3.origin.x = 2 * self.view.frame.size.width
        vc3.view.frame = frame3
        
        self.addChildViewController(vc3)
        self.scrollView.addSubview(vc3.view)
        vc3.didMoveToParentViewController(self)
        
        let vc4 = HowToPlayScreen4ViewController(nibName: "HowToPlayScreen4ViewController", bundle: nil)
        
        var frame4 = vc4.view.frame
        frame4.origin.x = 3 * self.view.frame.size.width
        vc4.view.frame = frame4
        
        self.addChildViewController(vc4)
        self.scrollView.addSubview(vc4.view)
        vc4.didMoveToParentViewController(self)
        
        self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width * 4, self.view.frame.size.height - 66)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
