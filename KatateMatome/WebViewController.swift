//
//  WebViewController.swift
//  ZukyunMatome
//
//  Created by 平松　亮介 on 2015/02/16.
//  Copyright (c) 2015年 himara2. All rights reserved.
//

import UIKit

class WebViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    var entry: Entry?
    
    @IBOutlet weak var browserBackButton: UIButton!
    @IBOutlet weak var browserGoButton: UIButton!
    @IBOutlet weak var actionButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.hidden = true

        if let entry = entry {
            self.title = entry.title
            webView.loadRequest(NSURLRequest(URL: NSURL(string: entry.link)!))
            webView.scalesPageToFit = true
        }

        setUpButtonStyle()
        
    }
    
    private func setUpButtonStyle() {
        setButtonStyle(browserBackButton)
        setButtonStyle(browserGoButton)
        setButtonStyle(actionButton)
    }
    
    private func setButtonStyle(button: UIButton) {
        button.backgroundColor = UIColor.defaultBGColor(alpha: 0.8)
        button.layer.cornerRadius = button.frame.size.width / 2
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.grayColor().CGColor
    }


    // MARK: Toolbar Action

    @IBAction func browserBackBtnTouched(sender: AnyObject) {
        if webView.canGoBack {
            webView.goBack()
        }
    }

    @IBAction func browserGoBtnTouched(sender: AnyObject) {
        if webView.canGoForward {
            webView.goForward()
        }
    }

    @IBAction func browserActionBtnTouched(sender: AnyObject) {

        let favActivity = FavActivity()
        
        let shareText = "\(entry!.title) \(entry!.link)"

        let activityView = UIActivityViewController(activityItems: [entry!, shareText],
            applicationActivities: [favActivity])
        self.presentViewController(activityView, animated: true, completion: nil)
    }


    // MARK: WebViewDelegate

    func webViewDidFinishLoad(webView: UIWebView) {
        browserBackButton.enabled = webView.canGoBack
        browserGoButton.enabled = webView.canGoForward
    }


}