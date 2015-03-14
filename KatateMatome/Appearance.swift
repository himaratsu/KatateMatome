//
//  Appearance.swift
//  ZukyunMatome
//
//  Created by 平松　亮介 on 2015/02/16.
//  Copyright (c) 2015年 himara2. All rights reserved.
//

import UIKit

class Appearance: NSObject {
   
    class func adjustAppearance() {
        
        // statubar color
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        
        // navigation barColor
        UINavigationBar.appearance().barTintColor = UIColor.defaultColor()
        
        // navigation textColor
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        
        // navigation bar button
        UIBarButtonItem.appearance().tintColor = UIColor.whiteColor()
        
        // navigation back button
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        
        // tabbar barcolor
//        UITabBar.appearance().barTintColor = UIColor.defaultColor()
        
        // hide tab bar shadow
        UITabBar.appearance().shadowImage = UIImage()
        
        // tabbar textColor
//        UITabBar.appearance().tintColor = UIColor.whiteColor()
        
        // separator
        UITableViewCell.appearance().separatorInset = UIEdgeInsetsZero
        UITableView.appearance().separatorColor = UIColor.color(0xD2C4B3, alpha: 1)
        
        
    }
}
