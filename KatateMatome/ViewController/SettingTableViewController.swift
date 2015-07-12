//
//  SettingTableViewController.swift
//  KatateMatome
//
//  Created by himara2 on 2015/03/18.
//  Copyright (c) 2015年 himara2. All rights reserved.
//

import UIKit
import Social

private let kAppStoreUrl = "https://itunes.apple.com/app/id978337038?mt=8"

class SettingTableViewController: UITableViewController, UIActionSheetDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "このアプリについて"
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel!.font = UIFont.systemFontOfSize(15)
        
        switch indexPath.row {
        case 0:
            cell.textLabel!.text = "このアプリを評価する"
        case 1:
            cell.textLabel!.text = "友達に教える"
//        case 2:
//            cell.textLabel!.text = "ソフトウェアライセンス"
        case 2:
            let appVersion = NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"] as! String
            cell.textLabel!.text = "アプリのバージョン \(appVersion)"
        default:
            break
        }

        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        switch indexPath.row {
        case 0:
            UIApplication.sharedApplication().openURL(NSURL(string: kAppStoreUrl)!)
        case 1:
            let actionSheet = UIActionSheet()
            actionSheet.delegate = self
            actionSheet.title = "友達に教える"
            actionSheet.addButtonWithTitle("Twitter")
            actionSheet.addButtonWithTitle("Facebook")
            actionSheet.addButtonWithTitle("LINE")
            actionSheet.addButtonWithTitle("キャンセル")
            actionSheet.cancelButtonIndex = 3
            
            actionSheet.showInView(self.view)
        case 2:
            // FIXME: ライセンスの表示
            print("do something...")
        default:
            break
        }
        
    }
    
    
    // MARK: UIActionSheetDelegate
    
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        if buttonIndex == actionSheet.cancelButtonIndex {
            // do nothing
        }
        else {
            
            let shareText = "この2ちゃんまとめリーダー片手で使えて超便利www \(kAppStoreUrl)"
            
            if buttonIndex == 0 {
                // twitter
                shareTwitter(shareText)
            }
            else if buttonIndex == 1 {
                // facebook
                shareFacebook(shareText)
            }
            else {
                // line
                if UIApplication.sharedApplication().canOpenURL(NSURL(string: "line://")!) {
                    let schemeUrl = "line://msg/text/\(shareText)"
                    
                    let encodedString = schemeUrl.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
                    UIApplication.sharedApplication().openURL(NSURL(string: encodedString!)!)
                }
                else {
                    UIAlertView.showAlert("LINEがインストールされていません！", message: "")
                }
            }
        }
    }
    
    
    // MARK: - Share SNS
    
    private func composeViewController(serviceType: String, message: String) -> SLComposeViewController {
        
        let vc = SLComposeViewController(forServiceType: serviceType)
        vc.setInitialText(message)
        vc.addURL(NSURL(string: kAppStoreUrl))
        
        return vc
    }
    
    private func shareTwitter(message: String) {
        let vc = composeViewController(SLServiceTypeTwitter, message:message)
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    private func shareFacebook(message: String) {
        let vc = composeViewController(SLServiceTypeFacebook, message:message)
        self.presentViewController(vc, animated: true, completion: nil)
    }
    

}
