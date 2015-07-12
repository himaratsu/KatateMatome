//
//  Parse.swift
//  KatateMatome
//
//  Created by himara2 on 2015/03/14.
//  Copyright (c) 2015年 himara2. All rights reserved.
//

import Foundation

private let day: NSTimeInterval = 60*60*24
private let week: NSTimeInterval = day * 7
private let month: NSTimeInterval = day * 30

enum Duration: Int {
    case Today = 0
    case ThisWeek = 1
    case ThisMonth = 2
    case All = 3
}

class ParseAPI: NSObject {

    class func fetchNewEntries(completionHandler: ([Entry]?, NSError?) -> Void) {
        
        let query = PFQuery(className:"Entry")
        
        if ReviewHelper.sharedInstance.isReviewMode {
            self.fetchWhiteListNewEntries(completionHandler)
            return
        }
        
        query.orderByDescending("posttime")
        
        if query.hasCachedResult() {
            query.cachePolicy = kPFCachePolicyCacheThenNetwork
        } else {
            query.cachePolicy = kPFCachePolicyNetworkOnly
        }
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
    
    
    class func fetchPopularEntries(duration: Duration, completionHandler: ([Entry]?, NSError?) -> Void) {
        
        let query = PFQuery(className:"Entry")
        
        if ReviewHelper.sharedInstance.isReviewMode {
            fetchWhiteListPopularEntries(duration, completionHandler: completionHandler)
            return
        }
        
        query.orderByDescending("hatebu")
        
        if query.hasCachedResult() {
            query.cachePolicy = kPFCachePolicyCacheThenNetwork
        } else {
            query.cachePolicy = kPFCachePolicyNetworkOnly
        }
        
        // 期間を選択
        var durationDate: NSDate?
        
        switch duration {
        case .Today:
            durationDate = NSDate(timeIntervalSinceNow: -day)
            query.whereKey("posttime", greaterThan: durationDate)
        case .ThisWeek:
            durationDate = NSDate(timeIntervalSinceNow: -week)
            query.whereKey("posttime", greaterThan: durationDate)
        case .ThisMonth:
            durationDate = NSDate(timeIntervalSinceNow: -month)
            query.whereKey("posttime", greaterThan: durationDate)
        case .All:
            break
        }
        
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
    
    class func postReportEntry(entryId: String, completionHandler: (Bool, NSError?) -> Void) {
        
        let report = PFObject(className: "Report")
        report["entryId"] = entryId
        
        report.saveInBackgroundWithBlock(completionHandler)
    }
    
    class func fetchReviewStatus(completionHandler: (Bool?, NSError?) -> Void) {
        
        let statusQuery = PFQuery(className: "Status")
        statusQuery.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if let error = error {
                completionHandler(nil, error)
            }
            else {
                if let obj = objects.first as? PFObject {
                    let isReview = obj["isReview"] as? Bool
                    completionHandler(isReview, nil)
                }
                else {
                    completionHandler(false, nil)
                }
            }
        }
    }
    
    
    // MARK: - WhiteList Mode
    
    class func fetchWhiteListNewEntries(completionHandler: ([Entry]?, NSError?) -> Void) {
        let query = PFQuery(className:"WhiteListEntry")
        
        query.orderByDescending("posttime")
        
        if query.hasCachedResult() {
            query.cachePolicy = kPFCachePolicyCacheThenNetwork
        } else {
            query.cachePolicy = kPFCachePolicyNetworkOnly
        }
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
    
    class func fetchWhiteListPopularEntries(duration: Duration, completionHandler: ([Entry]?, NSError?) -> Void) {
        let query = PFQuery(className:"WhiteListEntry")
        
        query.orderByDescending("hatebu")
        
        if query.hasCachedResult() {
            query.cachePolicy = kPFCachePolicyCacheThenNetwork
        } else {
            query.cachePolicy = kPFCachePolicyNetworkOnly
        }
        
        // 期間を選択
        var durationDate: NSDate?
        
        switch duration {
        case .Today:
            durationDate = NSDate(timeIntervalSinceNow: -day)
            query.whereKey("posttime", greaterThan: durationDate)
        case .ThisWeek:
            durationDate = NSDate(timeIntervalSinceNow: -week)
            query.whereKey("posttime", greaterThan: durationDate)
        case .ThisMonth:
            durationDate = NSDate(timeIntervalSinceNow: -month)
            query.whereKey("posttime", greaterThan: durationDate)
        case .All:
            break
        }
        
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
