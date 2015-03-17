//
//  CommonExtension.swift
//  KatateMatome
//
//  Created by himara2 on 2015/03/14.
//  Copyright (c) 2015年 himara2. All rights reserved.
//

import Foundation

extension UIColor {
    class func color(hex: Int, alpha: Double = 1.0) -> UIColor {
        let red = Double((hex & 0xFF0000) >> 16) / 255.0
        let green = Double((hex & 0xFF00) >> 8) / 255.0
        let blue = Double((hex & 0xFF)) / 255.0
        
        return UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: CGFloat(alpha))
    }
    
    class func defaultColor(alpha: Double = 1.0) -> UIColor {
        return UIColor.color(0x00aced, alpha: alpha)
    }
    
    class func defaultBGColor(alpha: Double = 1.0) -> UIColor {
        return UIColor.color(0xEBEBEB, alpha: alpha)
    }
}


// format int
extension Int {
    func format(f: String) -> String {
        return String(format: "%\(f)d", self)
    }
}


// show className
extension NSObject {
    public class var className:String {
        get {
            return NSStringFromClass(self).componentsSeparatedByString(".").last!
        }
    }
}
