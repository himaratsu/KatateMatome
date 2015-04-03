//
//  PopularViewController.swift
//  KatateMatome
//
//  Created by himara2 on 2015/03/14.
//  Copyright (c) 2015年 himara2. All rights reserved.
//

import UIKit

class PopularViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak private var tableView: UITableView!
    @IBOutlet weak var durationSegmentedControl: UISegmentedControl!
    private var refreshControl:UIRefreshControl!
    private var entries = [Entry]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpRefreshControl()
        
        registerNib()
        
        reloadIfNotReview()
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
    
    private func reloadIfNotReview() {
        ParseAPI.fetchReviewStatus { (isSuccess, error) -> Void in
            if error != nil {
                self.reload()
            }
            else {
                ReviewHelper.sharedInstance.isReviewMode = isSuccess!
                self.reload()
            }
        }
    }
    
    private func reload() {
        let durationMode = Duration(rawValue: durationSegmentedControl.selectedSegmentIndex) ?? .All
        ParseAPI.fetchPopularEntries(durationMode, completionHandler: { (entries, error) -> Void in
            if error != nil {
                if error!.code == 120 {
                    // cache miss ならスルー
                    return
                }
                UIAlertView.showAlert(title: "申し訳ありません", message: "データを取得できませんでした。")
            }
            else {
                if let entries = entries {
                    self.entries = entries
                    self.tableView.reloadData()
                }
            }
            self.refreshControl.endRefreshing()

        })
    }
    
    
    // MARK: - UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(EntryCell.className) as EntryCell
        
        let entry = entries[indexPath.row]
        cell.entry = entry
        
        if indexPath.row % 2 == 0 {
            cell.contentView.backgroundColor = UIColor.color(0xFCFCFC)
        }
        else {
            cell.contentView.backgroundColor = UIColor.color(0xF2F2F2)
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 75
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let entry = entries[indexPath.row]
        self.performSegueWithIdentifier("showWeb", sender: entry)
    }
    
    
    // MARK: - Storyboard
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showWeb" {
            let vc = segue.destinationViewController as WebViewController
            if let e = sender as? Entry {
                vc.entry = e
            }
        }
    }

    @IBAction func durationSegmentedControlChanged(sender: AnyObject) {
        reload()
    }
    
}
