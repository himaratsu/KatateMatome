//
//  ReportActivity.swift
//  KatateMatome
//
//  Created by 平松　亮介 on 2015/04/03.
//  Copyright (c) 2015年 himara2. All rights reserved.
//

import UIKit

class ReportActivity: UIActivity {
   
    override func activityType() -> String? {
        return "in.mashroom.report"
    }
    
    override func activityImage() -> UIImage? {
        return nil
    }
    
    override func activityTitle() -> String? {
        return "この記事を報告"
    }
    
    override func canPerformWithActivityItems(activityItems: [AnyObject]) -> Bool {
        for item in activityItems {
            if item is Entry {
                return true
            }
        }
        return false
    }
    
    override func prepareWithActivityItems(activityItems: [AnyObject]) {
        for item in activityItems {
            println(item)
            if item is Entry {
                // お気に入りに追加する
                ParseAPI.postReportEntry(item.objectId, completionHandler: { (isSuccess, error) -> Void in
                    if let error = error {
                        println("error occured. \(error)")
                    }
                    else {
                        println("post success. \(isSuccess)")
                    }
                })
                break
            }
        }
    }

}
