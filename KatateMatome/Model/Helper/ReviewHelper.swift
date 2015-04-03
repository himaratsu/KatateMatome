//
//  ReviewHelper.swift
//  KatateMatome
//
//  Created by 平松　亮介 on 2015/04/03.
//  Copyright (c) 2015年 himara2. All rights reserved.
//

import UIKit

class ReviewHelper: NSObject {
   
    class var sharedInstance : ReviewHelper {
        struct Static {
            static let instance : ReviewHelper = ReviewHelper()
        }
        return Static.instance
    }
    
    var isReviewMode = false 
    
}
