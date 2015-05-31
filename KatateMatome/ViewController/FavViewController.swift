//
//  FavViewController.swift
//  KatateMatome
//
//  Created by himara2 on 2015/03/18.
//  Copyright (c) 2015年 himara2. All rights reserved.
//

import UIKit

class FavViewController: CommonVC, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    private var refreshControl: UIRefreshControl!
    private var entries: RLMResults?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpRefreshControl()
        
        registerNib()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        reload()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.tabBarController?.tabBar.hidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setUpRefreshControl() {
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "引っ張って更新",
            attributes: [NSFontAttributeName:UIFont.systemFontOfSize(12),
                kCTForegroundColorAttributeName:[UIColor.lightGrayColor().CGColor]
            ])
        
        self.refreshControl.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl)
    }
    
    func refresh() {
        reload()
    }
    
    private func registerNib() {
        tableView.registerNib(UINib(nibName: EntryCell.className,
            bundle: NSBundle.mainBundle()),
            forCellReuseIdentifier: EntryCell.className)
    }
    
    private func reload() {
        self.entries = FavEntry.allObjects().sortedResultsUsingProperty("posttime", ascending: false)
        tableView.reloadData()
        
        self.refreshControl.endRefreshing()
    }

    
    // MARK: - UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            if let entries = entries {
                return Int(entries.count)
            }
            else {
                return 0
            }
        }
        else {
            return (entries?.count == 0) ? 1 : 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier(EntryCell.className) as! EntryCell
            
            if let entries = entries {
                let entry = entries[UInt(indexPath.row)] as! FavEntry
                cell.favEntry = entry
                
                if indexPath.row % 2 == 0 {
                    cell.contentView.backgroundColor = UIColor.color(0xFCFCFC)
                }
                else {
                    cell.contentView.backgroundColor = UIColor.color(0xF2F2F2)
                }
            }
            else {
                abort()
            }
            
            return cell
        }
        else {
            // NoCell
            let cell = tableView.dequeueReusableCellWithIdentifier("NoCell") as! UITableViewCell
            return cell
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 75
        }
        else {
            return 123
        }
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if let entries = entries {
            let entry = entries[UInt(indexPath.row)] as! FavEntry
            self.performSegueWithIdentifier("showWeb", sender: entry)
        }
    }
    
    
    // MARK: - Storyboard
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showWeb" {
            let vc = segue.destinationViewController as! WebViewController
            if let e = sender as? FavEntry {
                vc.entry = Entry(fromFavEntry: e)
            }
        }
    }


}
