//
//  AlertExtension.swift
//  KatateMatome
//
//  Created by himara2 on 2015/03/14.
//  Copyright (c) 2015年 himara2. All rights reserved.
//

import Foundation

extension UIAlertView {
    
    class func showAlert(title: String = "", message: String = "") {
        let alert = UIAlertView(title: title,
            message: message,
            delegate: nil,
            cancelButtonTitle: "OK",
            otherButtonTitles: "")
        alert.show()
    }
    
}