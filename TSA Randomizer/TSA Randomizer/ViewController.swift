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
    
    // Ad banner and interstitial views
    var adMobBannerView = GADBannerView()
    
    @IBOutlet weak var removeAdsButton: UIButton!
    
    @IBOutlet weak var restorePurchasesButton: UIButton!
    
    // IMPORTANT: REPLACE THE RED STRING BELOW WITH THE AD UNIT ID YOU'VE GOT BY REGISTERING YOUR APP IN http://apps.admob.com
    let ADMOB_BANNER_UNIT_ID = "ca-app-pub-9733347540588953/7805958028"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Init AdMob banner
        initAdMobBanner()
        
        IAPService.shared.getProducts()
        
        //Check if product is purchased
        if (UserDefaults.standard.bool(forKey: "purchased")) {
            // Hide ads
            removeAdsButton.isHidden = true
            restorePurchasesButton.isHidden = true
        } 
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
    
    @IBAction func removeAdsButton(_ sender: Any) {
        IAPService.shared.purchase(product: .removeads)
        if (UserDefaults.standard.bool(forKey: "purchased")) {
            adMobBannerView.isHidden = true
            removeAdsButton.isHidden = true
            restorePurchasesButton.isHidden = true   // hidden because remove ads is only IAP
        }
    }
    
    @IBAction func restorePurchasesButton(_ sender: Any) {
        IAPService.shared.restorePurchases()
        if (UserDefaults.standard.bool(forKey: "purchased")) {
            adMobBannerView.isHidden = true
            removeAdsButton.isHidden = true
            restorePurchasesButton.isHidden = true   // hidden because remove ads is only IAP
        }
    }
    
    // MARK: -  ADMOB BANNER
    func initAdMobBanner() {
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            // iPhone
            adMobBannerView.adSize =  GADAdSizeFromCGSize(CGSize(width: 320, height: 50))
            adMobBannerView.frame = CGRect(x: 0, y: view.frame.size.height, width: 320, height: 50)
        } else  {
            // iPad
            adMobBannerView.adSize =  GADAdSizeFromCGSize(CGSize(width: 468, height: 60))
            adMobBannerView.frame = CGRect(x: 0, y: view.frame.size.height, width: 468, height: 60)
        }
        
        adMobBannerView.adUnitID = ADMOB_BANNER_UNIT_ID
        adMobBannerView.rootViewController = self
        adMobBannerView.delegate = self
        view.addSubview(adMobBannerView)
        
        let request = GADRequest()
        adMobBannerView.load(request)
    }
   
    // Hide the banner
    func hideBanner(_ banner: UIView) {
        UIView.beginAnimations("hideBanner", context: nil)
        banner.frame = CGRect(x: view.frame.size.width/2 - banner.frame.size.width/2, y: view.frame.size.height - banner.frame.size.height, width: banner.frame.size.width, height: banner.frame.size.height)
        UIView.commitAnimations()
        banner.isHidden = true
    }
    
    // Show the banner
    func showBanner(_ banner: UIView) {
        UIView.beginAnimations("showBanner", context: nil)
        banner.frame = CGRect(x: view.frame.size.width/2 - banner.frame.size.width/2, y: view.frame.size.height - banner.frame.size.height, width: banner.frame.size.width, height: banner.frame.size.height)
        UIView.commitAnimations()
        banner.isHidden = false
    }
    
    // AdMob banner available
    func adViewDidReceiveAd(_ view: GADBannerView) {
        showBanner(adMobBannerView)
    }
    
    // NO AdMob banner available
    func adView(_ view: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        hideBanner(adMobBannerView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

