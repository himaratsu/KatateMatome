//
//  FavActivity.swift
//  KatateMatome
//
//  Created by himara2 on 2015/03/18.
//  Copyright (c) 2015年 himara2. All rights reserved.
//

import UIKit

class FavActivity: UIActivity {
   
    override func activityType() -> String? {
        return "in.mashroom.fav"
    }
    
    override func activityImage() -> UIImage? {
        return nil
    }
    
    override func activityTitle() -> String? {
        return "お気に入り追加"
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
                // お気に入りに追加する
                FavHelper.sharedInstance.favEntry(item as! Entry)
                
                let alert = UIAlertView()
                alert.title = "Success!"
                alert.message = "この記事をお気に入りに追加しました"
                alert.addButtonWithTitle("OK")
                alert.show()
                break
            }
        }
    }
    
}
