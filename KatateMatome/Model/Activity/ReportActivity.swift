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
            print(item)
            if item is Entry {
                // 記事を報告する
                ParseAPI.postReportEntry(item.objectId, completionHandler: { (isSuccess, error) -> Void in
                    if let error = error {
                        print("error occured. \(error)")
                    }
                    else {
                        let alert = UIAlertView()
                        alert.title = "ご報告ありがとうございます"
                        alert.message = "報告頂いたこちらの記事は数時間以内に運営側にて対応いたします。"
                        alert.addButtonWithTitle("OK")
                        alert.show()
                    }
                })
                break
            }
        }
    }

}
