//
//  FavEntry.swift
//  KatateMatome
//
//  Created by himara2 on 2015/03/18.
//  Copyright (c) 2015年 himara2. All rights reserved.
//

import UIKit

class FavEntry: RLMObject {
   
    dynamic var objectId    : String!
    dynamic var blogTitle   : String!
    dynamic var link = ""
    dynamic var title       : String!
    dynamic var posttime    : NSDate!
    dynamic var createdAt   : NSDate?
    dynamic var updatedAt   : NSDate?
    dynamic var hatebu      = 0

    override init() {
        super.init()
    }
    
    init(fromEntry entry:Entry) {
        self.objectId = entry.objectId
        self.blogTitle = entry.blogTitle
        self.link = entry.link
        self.title = entry.title
        self.posttime = entry.posttime
        
        if let createdAt = self.createdAt {
            self.createdAt = entry.createdAt
        }
        else {
            self.createdAt = NSDate(timeIntervalSince1970: 0)
        }

        if let updatedAt = self.updatedAt {
            self.updatedAt = entry.updatedAt
        }
        else {
            self.updatedAt = NSDate(timeIntervalSince1970: 0)
        }
        
        self.hatebu = entry.hatebu
        
        super.init()
    }
    
    override class func primaryKey() -> String {
        return "link"
    }
    
}
