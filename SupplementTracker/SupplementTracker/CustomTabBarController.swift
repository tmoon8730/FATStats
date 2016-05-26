//
//  CustomTabBarController.swift
//  Nutriments
//
//  Created by Debbie Moon on 5/25/16.
//  Copyright © 2016 Tyler Moon. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController{
    override func viewDidLoad(){
        super.viewDidLoad()
        
        self.tabBar.barTintColor = UIColor.nutrimentsPrimaryBlue()
        
        let allItems:[AnyObject] = self.tabBar.items!
        let todayItem: UITabBarItem = allItems[0] as! UITabBarItem
        let exerciseItem: UITabBarItem = allItems[1] as! UITabBarItem
        let supplementItem: UITabBarItem = allItems[2] as! UITabBarItem
        let trackerItem: UITabBarItem = allItems[3] as! UITabBarItem
        
        todayItem.image = UIImage(named: "calendar.png")!.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        exerciseItem.image = UIImage(named: "weight@2x.png")!.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        supplementItem.image = UIImage(named: "pill-icon@2x.png")!.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        trackerItem.image = UIImage(named: "clipboard.png")!.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        
        
        todayItem.selectedImage = UIImage(named: "calendar@2x.png")!
        exerciseItem.selectedImage = UIImage(named: "weight@2x.png")!
        supplementItem.selectedImage = UIImage(named: "pill-icon@2x.png")!
        trackerItem.selectedImage = UIImage(named: "clipboard.png")!
        
        
        
        
        
        todayItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.nutrimentsAccentOrange()], forState: .Normal)
        todayItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.whiteColor()], forState: .Selected)
        
        exerciseItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.nutrimentsAccentOrange()], forState: .Normal)
        exerciseItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.whiteColor()], forState: .Selected)
        
        supplementItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.nutrimentsAccentOrange()], forState: .Normal)
        supplementItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.whiteColor()], forState: .Selected)
        
        trackerItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.nutrimentsAccentOrange()], forState: .Normal)
        trackerItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.whiteColor()], forState: .Selected)
        
        self.tabBar.tintColor = UIColor.whiteColor()
    }
}

