//
//  RecommendViewController.swift
//  ZukyunMatome
//
//  Created by 平松　亮介 on 2015/02/18.
//  Copyright (c) 2015年 himara2. All rights reserved.
//

import UIKit

class RecommendViewController: UIViewController, IMobileSdkAdsDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

//        ImobileSdkAds.setSpotDelegate("384175", delegate: self)
//        ImobileSdkAds.showBySpotID("384175")
        
        // for test
        ImobileSdkAds.setSpotDelegate("349869", delegate: self)
        ImobileSdkAds.showBySpotID("349869")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imobileSdkAdsSpotIsNotReady(spotId: String!) {
        println("not ready")
    }

    func imobileSdkAdsSpot(spotId: String!, didFailWithValue value: ImobileSdkAdsFailResult) {
        println("fail")
        
    }


}
