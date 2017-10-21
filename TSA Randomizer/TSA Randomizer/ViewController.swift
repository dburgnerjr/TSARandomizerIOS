//
//  ViewController.swift
//  TSA Randomizer
//
//  Created by Daniel Burgner on 7/9/17.
//  Copyright © 2017 Daniel Burgner. All rights reserved.
//

import GoogleMobileAds
import UIKit
import StoreKit

class ViewController: UIViewController, GADBannerViewDelegate {
    
    @IBOutlet weak var bannerView: GADBannerView!
    @IBOutlet weak var removeAdsButton: UIButton!
    @IBOutlet weak var restorePurchasesButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        bannerView.isHidden = true
        bannerView.delegate = self
        bannerView.adUnitID = "ca-app-pub-9733347540588953/7805958028"
        bannerView.adSize = kGADAdSizeSmartBannerPortrait
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        
//        IAPService.shared.getProducts()
//
//        //Check if product is purchased
//        if (UserDefaults.standard.bool(forKey: "purchased")) {
//            // Hide ads
//            removeAdsButton.isHidden = true
//            restorePurchasesButton.isHidden = true
//        }
    }
    
    @IBAction func shareButton(_ sender: Any) {
        //Set the default sharing message.
        let message = "Check out this app I downloaded."
        //Set the link to share.
        if let link = NSURL(string: "itms-apps://itunes.apple.com/us/app/tsa-randomizer/id1291775688?ls=1&mt=8")
        {
            let objectsToShare = [message,link] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            activityVC.excludedActivityTypes = [UIActivityType.airDrop, UIActivityType.addToReadingList]
            self.present(activityVC, animated: true, completion: nil)
        }
    }
    
//    @IBAction func removeAdsButton(_ sender: Any) {
//        IAPService.shared.purchase(product: .removeads)
//        if (UserDefaults.standard.bool(forKey: "purchased")) {
//            adMobBannerView.isHidden = true
//            removeAdsButton.isHidden = true
//            restorePurchasesButton.isHidden = true   // hidden because remove ads is only IAP
//        }
//    }
//
//    @IBAction func restorePurchasesButton(_ sender: Any) {
//        IAPService.shared.restorePurchases()
//        if (UserDefaults.standard.bool(forKey: "purchased")) {
//            adMobBannerView.isHidden = true
//            removeAdsButton.isHidden = true
//            restorePurchasesButton.isHidden = true   // hidden because remove ads is only IAP
//        }
//    }
        
    // AdMob banner available
    func adViewDidReceiveAd(_ view: GADBannerView) {
        bannerView.isHidden = false
    }
    
    // NO AdMob banner available
    func adView(_ view: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        bannerView.isHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

