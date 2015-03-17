//
//  Entry.swift
//  KatateMatome
//
//  Created by himara2 on 2015/03/14.
//  Copyright (c) 2015年 himara2. All rights reserved.
//

import Foundation

class Entry: NSObject {

    dynamic var objectId    : String!
    dynamic var blogTitle   : String!
    dynamic var link        : String!
    dynamic var title       : String!
    dynamic var posttime    : NSDate!
    dynamic var createdAt   : NSDate!
    dynamic var updatedAt   : NSDate!
    dynamic var hatebu      = 0

    
    init(objectId: String, blogTitle: String, link: String, title: String,
        posttime: NSDate, createdAt: NSDate, updatedAt: NSDate, hatebu: Int) {
            self.objectId = objectId
            self.blogTitle = blogTitle
            self.link = link
            self.title = title
            self.posttime = posttime
            self.createdAt = createdAt
            self.updatedAt = updatedAt
            self.hatebu = hatebu
            
            super.init()
    }
    
    init(fromPFObject pfObject: PFObject) {
        self.objectId = pfObject.objectId
        self.blogTitle = pfObject["blogTitle"] as? String
        self.link = pfObject["link"] as? String
        self.title = pfObject["title"] as? String
        self.posttime = pfObject["posttime"] as? NSDate
        self.createdAt = pfObject["createdAt"] as? NSDate
        self.updatedAt = pfObject["updatedAt"] as? NSDate
        self.hatebu = ((pfObject["hatebu"] as? NSNumber) as? Int) ?? 0
        
        super.init()
    }
    
    init(fromFavEntry favEntry:FavEntry) {
        self.objectId = favEntry.objectId
        self.blogTitle = favEntry.blogTitle
        self.link = favEntry.link
        self.title = favEntry.title
        self.posttime = favEntry.posttime
        self.createdAt = favEntry.createdAt
        self.updatedAt = favEntry.updatedAt
        self.hatebu = favEntry.hatebu
        
        super.init()
    }
    
    
}
