//
//  EntryCell.swift
//  ZukyunMatome
//
//  Created by 平松　亮介 on 2015/02/16.
//  Copyright (c) 2015年 himara2. All rights reserved.
//

import UIKit

class EntryCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var siteNameLabel: UILabel!
    @IBOutlet weak var bookmarkLabel: UILabel!
    
    var entry: Entry? = nil {
        didSet {
            if let entry = entry {
                titleLabel.text = entry.title
                siteNameLabel.text = entry.blogTitle
                
                if let date = entry.posttime {
                    let dateFormatter = NSDateFormatter()
                    dateFormatter.dateFormat = "MM/dd HH:mm"
                    timeLabel.text = dateFormatter.stringFromDate(date)
                }
                
                if let hatebu = entry.hatebu {
                    self.bookmarkLabel.text = "\(hatebu) users"
                }
                else {
                    self.bookmarkLabel.text = "- users"
                }
            }
        }
    }
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
