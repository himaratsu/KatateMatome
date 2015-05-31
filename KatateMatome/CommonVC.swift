//
//  CommonVC.swift
//  KatateMatome
//
//  Created by himara2 on 2015/05/29.
//  Copyright (c) 2015年 himara2. All rights reserved.
//

import UIKit

class CommonVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpBottomBackButton()
    }

    private func setUpBottomBackButton() {
        let backButton = UIButton(frame: CGRectMake(15, 0, 44, 44))
        backButton.setTitle("<Back", forState: UIControlState.Normal)
        backButton.backgroundColor = UIColor.lightGrayColor()
        backButton.layer.masksToBounds = true
        backButton.layer.cornerRadius = 22
        backButton.titleLabel?.font = UIFont.systemFontOfSize(13.0)
        backButton.frame.origin.y = self.view.frame.size.height - 120
        self.view.addSubview(backButton)
        
        backButton.addTarget(self, action: "backButtonTouched", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func backButtonTouched() {
        self.navigationController?.popViewControllerAnimated(true)
    }

}
