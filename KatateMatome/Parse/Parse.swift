//
//  Parse.swift
//  KatateMatome
//
//  Created by himara2 on 2015/03/14.
//  Copyright (c) 2015年 himara2. All rights reserved.
//

import Foundation

class ParseAPI: NSObject {

    class func fetchNewEntries(completionHandler: ([Entry]?, NSError?) -> Void) {
        
        let query = PFQuery(className:"Entry")
        query.orderByDescending("posttime")
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if error == nil && objects != nil {
                // success
                var entries = [Entry]()
                for obj in objects {
                    if let obj = obj as? PFObject {
                        let e = Entry(fromPFObject: obj)
                        entries.append(e)
                    }
                }
                
                completionHandler(entries, nil)
            }
            else {
                // failed
                completionHandler(nil, error)
            }
        }
    }
}
