//
//  FavHelper.swift
//  KatateMatome
//
//  Created by himara2 on 2015/03/18.
//  Copyright (c) 2015年 himara2. All rights reserved.
//

import UIKit

class FavHelper: NSObject {
    
    class var sharedInstance : FavHelper {
        struct Static {
            static let instance : FavHelper = FavHelper()
        }
        return Static.instance
    }
 
    
    // 記事をお気に入りする
    func favEntry(entry: Entry) {
        let favEntry = FavEntry(fromEntry: entry)
        let realm = RLMRealm.defaultRealm()
        realm.transactionWithBlock({ () -> Void in
            realm.addOrUpdateObject(favEntry)
        })
    }
    
}
