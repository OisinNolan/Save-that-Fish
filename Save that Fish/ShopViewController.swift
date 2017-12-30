//
//  ShopViewController.swift
//  Save that Fish
//
//  Created by Nuala O' Dea on 02/09/2015.
//  Copyright (c) 2015 oisinnolan. All rights reserved.
//

import UIKit

class ShopViewController: UIViewController {

    @IBOutlet weak var fishButton: UIButton!
    @IBOutlet weak var jellyfishButton: UIButton!
    @IBOutlet weak var bigfishButton: UIButton!
    @IBOutlet weak var turtleButton: UIButton!
    @IBOutlet weak var dolphinButton: UIButton!
    @IBOutlet weak var seahorseButton: UIButton!
    
    @IBOutlet weak var notenoughstarsView: UIView!
    
    @IBOutlet weak var coinAmountLabel: UILabel!
    
    @IBOutlet weak var fishImage: UIImageView!
    @IBOutlet weak var jellyfishImage: UIImageView!
    @IBOutlet weak var turtleImage: UIImageView!
    @IBOutlet weak var dolphinImage: UIImageView!
    @IBOutlet weak var seahorseImage: UIImageView!
    @IBOutlet weak var bigfishImage: UIImageView!
    
    @IBOutlet weak var fishView: UIView!
    @IBOutlet weak var jellyfishView: UIView!
    @IBOutlet weak var bigfishView: UIView!
    @IBOutlet weak var turtleView: UIView!
    @IBOutlet weak var dolphinView: UIView!
    @IBOutlet weak var seahorseView: UIView!
    
    @IBOutlet weak var priceLabel1: UILabel!
    @IBOutlet weak var coinImage1: UIImageView!
    @IBOutlet weak var priceLabel2: UILabel!
    @IBOutlet weak var coinImage2: UIImageView!
    @IBOutlet weak var priceLabel3: UILabel!
    @IBOutlet weak var coinLabel3: UIImageView!
    @IBOutlet weak var priceLabel4: UILabel!
    @IBOutlet weak var coinImage4: UIImageView!
    @IBOutlet weak var priceLabel5: UILabel!
    @IBOutlet weak var coinImage5: UIImageView!
    
    @IBOutlet weak var backButton: UIBarButtonItem!
    
    let gameVC = GameViewController()
    
    var isBought1 = Bool()
    var isBought2 = Bool()
    var isBought3 = Bool()
    var isBought4 = Bool()
    var isBought5 = Bool()
    var isBought6 = Bool()
    
    var isSelected1 = Bool()
    var isSelected2 = Bool()
    var isSelected3 = Bool()
    var isSelected4 = Bool()
    var isSelected5 = Bool()
    var isSelected6 = Bool()
    
    var firstTimeDone = Bool()
    
    var coinAmount = Int()
    
    var oneSelected = Bool()
    
    var selectedView = String()
    
    var price = Int()
    
    var selectedChar = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fishView.backgroundColor = UIColor(hue: 0.6833, saturation: 0.64, brightness: 0.92, alpha: 1.0)
        jellyfishView.backgroundColor = UIColor(hue: 0.6833, saturation: 0.64, brightness: 0.92, alpha: 1.0)
        bigfishView.backgroundColor = UIColor(hue: 0.6833, saturation: 0.64, brightness: 0.92, alpha: 1.0)
        turtleView.backgroundColor = UIColor(hue: 0.6833, saturation: 0.64, brightness: 0.92, alpha: 1.0)
        dolphinView.backgroundColor = UIColor(hue: 0.6833, saturation: 0.64, brightness: 0.92, alpha: 1.0)
        seahorseView.backgroundColor = UIColor(hue: 0.6833, saturation: 0.64, brightness: 0.92, alpha: 1.0)
        
        isBought1 = true
        isBought2 = NSUserDefaults.standardUserDefaults().boolForKey("isBought2")
        isBought3 = NSUserDefaults.standardUserDefaults().boolForKey("isBought3")
        isBought4 = NSUserDefaults.standardUserDefaults().boolForKey("isBought4")
        isBought5 = NSUserDefaults.standardUserDefaults().boolForKey("isBought5")
        isBought6 = NSUserDefaults.standardUserDefaults().boolForKey("isBought6")
        
        if !firstTimeDone {
            
            isSelected1 = true
            NSUserDefaults.standardUserDefaults().setBool(isSelected1, forKey: "isSelected1")
            oneSelected = true
            NSUserDefaults.standardUserDefaults().setBool(oneSelected, forKey: "oneSelected")
            firstTimeDone = true
            NSUserDefaults.standardUserDefaults().setBool(firstTimeDone, forKey: "firstTime")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
        
        isSelected1 = NSUserDefaults.standardUserDefaults().boolForKey("isSelected1")
        isSelected2 = NSUserDefaults.standardUserDefaults().boolForKey("isSelected2")
        isSelected3 = NSUserDefaults.standardUserDefaults().boolForKey("isSelected3")
        isSelected4 = NSUserDefaults.standardUserDefaults().boolForKey("isSelected4")
        isSelected5 = NSUserDefaults.standardUserDefaults().boolForKey("isSelected5")
        isSelected6 = NSUserDefaults.standardUserDefaults().boolForKey("isSelected6")
        
        oneSelected = NSUserDefaults.standardUserDefaults().boolForKey("oneSelected")
        
        coinAmount = NSUserDefaults.standardUserDefaults().integerForKey("coinAmount")
        NSUserDefaults.standardUserDefaults().synchronize()
        coinAmountLabel.text = String(coinAmount)
        
        notenoughstarsView.hidden = true
        
        checkStatus()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func selectView(view: String) {
        deselectView()
        selectedView = view
        if selectedView == "fishView" {
            isSelected1 = true
            NSUserDefaults.standardUserDefaults().setBool(isSelected1, forKey: "isSelected1")
            NSUserDefaults.standardUserDefaults().synchronize()
            fishView.backgroundColor = UIColor(hue: 0.5278, saturation: 1, brightness: 1, alpha: 1.0)
            setChar(1)
        }
        if selectedView == "jellyfishView" {
            isSelected2 = true
            NSUserDefaults.standardUserDefaults().setBool(isSelected2, forKey: "isSelected2")
            NSUserDefaults.standardUserDefaults().synchronize()
            jellyfishView.backgroundColor = UIColor(hue: 0.5278, saturation: 1, brightness: 1, alpha: 1.0)
            setChar(2)
        }
        if selectedView == "bigfishView" {
            isSelected3 = true
            NSUserDefaults.standardUserDefaults().setBool(isSelected3, forKey: "isSelected3")
            NSUserDefaults.standardUserDefaults().synchronize()
            bigfishView.backgroundColor = UIColor(hue: 0.5278, saturation: 1, brightness: 1, alpha: 1.0)
            setChar(3)
        }
        if selectedView == "turtleView" {
            isSelected4 = true
            NSUserDefaults.standardUserDefaults().setBool(isSelected4, forKey: "isSelected4")
            NSUserDefaults.standardUserDefaults().synchronize()
            turtleView.backgroundColor = UIColor(hue: 0.5278, saturation: 1, brightness: 1, alpha: 1.0)
            setChar(4)
        }
        if selectedView == "dolphinView" {
            isSelected5 = true
            NSUserDefaults.standardUserDefaults().setBool(isSelected5, forKey: "isSelected5")
            NSUserDefaults.standardUserDefaults().synchronize()
            dolphinView.backgroundColor = UIColor(hue: 0.5278, saturation: 1, brightness: 1, alpha: 1.0)
            setChar(5)
        }
        if selectedView == "seahorseView" {
            isSelected6 = true
            NSUserDefaults.standardUserDefaults().setBool(isSelected6, forKey: "isSelected6")
            NSUserDefaults.standardUserDefaults().synchronize()
            seahorseView.backgroundColor = UIColor(hue: 0.5278, saturation: 1, brightness: 1, alpha: 1.0)
            setChar(6)
        }
        
    }
    
    func deselectView() {
        
        var deselect = selectedView
        
        if deselect == "fishView" {
            isSelected1 = false
            NSUserDefaults.standardUserDefaults().setBool(isSelected1, forKey: "isSelected1")
            NSUserDefaults.standardUserDefaults().synchronize()
            fishView.backgroundColor = UIColor(hue: 0.6833, saturation: 0.64, brightness: 0.92, alpha: 1.0)
        }
        if deselect == "jellyfishView" {
            isSelected2 = false
            NSUserDefaults.standardUserDefaults().setBool(isSelected2, forKey: "isSelected2")
            NSUserDefaults.standardUserDefaults().synchronize()
            jellyfishView.backgroundColor = UIColor(hue: 0.6833, saturation: 0.64, brightness: 0.92, alpha: 1.0)
        }
        if deselect == "bigfishView" {
            isSelected3 = false
            NSUserDefaults.standardUserDefaults().setBool(isSelected3, forKey: "isSelected3")
            NSUserDefaults.standardUserDefaults().synchronize()
            bigfishView.backgroundColor = UIColor(hue: 0.6833, saturation: 0.64, brightness: 0.92, alpha: 1.0)
        }
        if deselect == "turtleView" {
            isSelected4 = false
            NSUserDefaults.standardUserDefaults().setBool(isSelected4, forKey: "isSelected4")
            NSUserDefaults.standardUserDefaults().synchronize()
            turtleView.backgroundColor = UIColor(hue: 0.6833, saturation: 0.64, brightness: 0.92, alpha: 1.0)
        }
        if deselect == "dolphinView" {
            isSelected5 = false
            NSUserDefaults.standardUserDefaults().setBool(isSelected5, forKey: "isSelected5")
            NSUserDefaults.standardUserDefaults().synchronize()
            dolphinView.backgroundColor = UIColor(hue: 0.6833, saturation: 0.64, brightness: 0.92, alpha: 1.0)
        }
        if deselect == "seahorseView" {
            isSelected6 = false
            NSUserDefaults.standardUserDefaults().setBool(isSelected6, forKey: "isSelected6")
            NSUserDefaults.standardUserDefaults().synchronize()
            seahorseView.backgroundColor = UIColor(hue: 0.6833, saturation: 0.64, brightness: 0.92, alpha: 1.0)
        }
        
    }
    
    func setChar(char: Int) {
        
        selectedChar = char
        NSUserDefaults.standardUserDefaults().setInteger(selectedChar, forKey: "selectedChar")
        NSUserDefaults.standardUserDefaults().synchronize()
        
        gameVC.checkChar()
        
    }
    
    func updateCoinAmount() {
        
        NSUserDefaults.standardUserDefaults().setInteger(coinAmount, forKey: "coinAmount")
        
    }
    
    func notEnoughStars() {
    
        notenoughstarsView.hidden = false
        notenoughstarsView.alpha = 1.0
        
        UIView.animateWithDuration(2.0, animations: {
            self.notenoughstarsView.alpha = 0.0
            }, completion: nil)
        
    }
    
    func checkStatus() {
        
        NSLog("checkstatus")
        
        if isSelected1 && isBought1{
            selectView("fishView")
        }
        
        NSLog(String(stringInterpolationSegment: isSelected2))
        NSLog(String(stringInterpolationSegment: isBought2))
        
        if isSelected2 && isBought2{
            selectView("jellyfishView")
            jellyfishImage.image = UIImage(named: "jellyfishShop")
            priceLabel1.hidden = true
            coinImage1.hidden = true
        }
        if !isSelected2 && isBought2{
            jellyfishImage.image = UIImage(named: "jellyfishShop")
            priceLabel1.hidden = true
            coinImage1.hidden = true
        }
        
        if isSelected3 && isBought3{
            selectView("bigfishView")
            bigfishImage.image = UIImage(named: "bigfishShop")
            priceLabel2.hidden = true
            coinImage2.hidden = true
        }
        if !isSelected3 && isBought3{
            bigfishImage.image = UIImage(named: "bigfishShop")
            priceLabel2.hidden = true
            coinImage2.hidden = true
        }
        
        if isSelected4 && isBought4{
            selectView("turtleView")
            turtleImage.image = UIImage(named: "turtleShop")
            priceLabel3.hidden = true
            coinLabel3.hidden = true
        }
        if !isSelected4 && isBought4{
            turtleImage.image = UIImage(named: "turtleShop")
            priceLabel3.hidden = true
            coinLabel3.hidden = true
        }
        
        if isSelected5 && isBought5{
            selectView("dolphinView")
            dolphinImage.image =  UIImage(named: "dolphinShop")
            priceLabel4.hidden = true
            coinImage4.hidden = true
        }
        if !isSelected5 && isBought5{
            dolphinImage.image =  UIImage(named: "dolphinShop")
            priceLabel4.hidden = true
            coinImage4.hidden = true
        }
        
        if isSelected6 && isBought6{
            selectView("seahorseView")
            seahorseImage.image = UIImage(named: "seahorseShop")
            priceLabel5.hidden = true
            coinImage5.hidden = true
        }
        
        if !isSelected6 && isBought6{
            seahorseImage.image = UIImage(named: "seahorseShop")
            priceLabel5.hidden = true
            coinImage5.hidden = true
        }
        
    }
    
    @IBAction func action1(sender: AnyObject) {
        
        if isBought1 && !isSelected1 {
            
            selectView("fishView")
            
        }
        
    }
    
    @IBAction func action2(sender: AnyObject) {
        
        if !isBought2 && !isSelected2 {
            
            price = 50
            
            if coinAmount >= price {
                coinAmount -= price
                updateCoinAmount()
                selectView("jellyfishView")
                isBought2 = true
                NSUserDefaults.standardUserDefaults().setBool(isBought2, forKey: "isBought2")
                NSUserDefaults.standardUserDefaults().synchronize()
                jellyfishImage.image = UIImage(named: "jellyfishShop")
                priceLabel1.hidden = true
                coinImage1.hidden = true
                coinAmountLabel.text = String(coinAmount)
            }
                
            else {
                
                notEnoughStars()
                
            }
            
        }
        
        if isBought2 && !isSelected2 {
            
            selectView("jellyfishView")
            
        }
        
    }
    
    @IBAction func action3(sender: AnyObject) {
        
        if !isBought3 && !isSelected3 {
            
            price = 100
            
            if coinAmount >= price {
                coinAmount -= price
                updateCoinAmount()
                selectView("bigfishView")
                isBought3 = true
                NSUserDefaults.standardUserDefaults().setBool(isBought3, forKey: "isBought3")
                NSUserDefaults.standardUserDefaults().synchronize()
                bigfishImage.image = UIImage(named: "bigfishShop")
                priceLabel2.hidden = true
                coinImage2.hidden = true
                coinAmountLabel.text = String(coinAmount)
            }
                
            else {
                
                notEnoughStars()
                
            }
            
        }
        
        if isBought3 && !isSelected3 {
            
            selectView("bigfishView")
            
        }
        
    }
    
    @IBAction func action4(sender: AnyObject) {
        
        if !isBought4 && !isSelected4 {
            
            price = 150
            
            if coinAmount >= price {
                coinAmount -= price
                updateCoinAmount()
                selectView("turtleView")
                isBought4 = true
                NSUserDefaults.standardUserDefaults().setBool(isBought4, forKey: "isBought4")
                NSUserDefaults.standardUserDefaults().synchronize()
                turtleImage.image = UIImage(named: "turtleShop")
                priceLabel3.hidden = true
                coinLabel3.hidden = true
                coinAmountLabel.text = String(coinAmount)
            }
                
            else {
                
                notEnoughStars()
                
            }
            
        }
        
        if isBought4 && !isSelected4 {
            
            selectView("turtleView")
            
        }
        
    }
    
    @IBAction func action5(sender: AnyObject) {
        
        if !isBought5 && !isSelected5 {
            
            price = 200
            
            if coinAmount >= price {
                coinAmount -= price
                updateCoinAmount()
                selectView("dolphinView")
                isBought5 = true
                NSUserDefaults.standardUserDefaults().setBool(isBought5, forKey: "isBought5")
                NSUserDefaults.standardUserDefaults().synchronize()
                dolphinImage.image = UIImage(named: "dolphinShop")
                priceLabel4.hidden = true
                coinImage4.hidden = true
                coinAmountLabel.text = String(coinAmount)
            }
                
            else {
                
                notEnoughStars()
                
            }
            
        }
        
        if isBought5 && !isSelected5 {
            
            selectView("dolphinView")
            
        }
        
    }
    
    @IBAction func action6(sender: AnyObject) {
        
        if !isBought6 && !isSelected6 {
            
            price = 300
            
            if coinAmount >= price {
                coinAmount -= price
                updateCoinAmount()
                selectView("seahorseView")
                isBought6 = true
                NSUserDefaults.standardUserDefaults().setBool(isBought6, forKey: "isBought6")
                NSUserDefaults.standardUserDefaults().synchronize()
                seahorseImage.image = UIImage(named: "seahorseShop")
                priceLabel5.hidden = true
                coinImage5.hidden = true
                coinAmountLabel.text = String(coinAmount)
            }
                
            else {
                
                notEnoughStars()
                
            }
            
        }
        
        if isBought6 && !isSelected6 {
            
            selectView("seahorseView")
            
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

