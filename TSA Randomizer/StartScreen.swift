//
//  StartScreen.swift
//  TSA Randomizer
//
//  Created by Daniel Burgner on 7/11/17.
//  Copyright © 2017 Daniel Burgner. All rights reserved.
//

import GoogleMobileAds
import UIKit

class StartScreen: UIViewController, GADBannerViewDelegate {
    
    @IBOutlet weak var arrowView: UIImageView!
    @IBOutlet weak var clickHereButton: UIButton!

    // Ad banner and interstitial views
    var adMobBannerView = GADBannerView()
    
    // IMPORTANT: REPLACE THE RED STRING BELOW WITH THE AD UNIT ID YOU'VE GOT BY REGISTERING YOUR APP IN http://apps.admob.com
    let ADMOB_BANNER_UNIT_ID = "ca-app-pub-9733347540588953/7805958028"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Init AdMob banner
        initAdMobBanner()
        //Check if product is purchased
        if (UserDefaults.standard.bool(forKey: "purchased")) {
            // Hide ads
            adMobBannerView.isHidden = true
        } else {
            showBanner(adMobBannerView)
        }

        clickHereButton.isHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @IBAction func clickHereButton(_ sender: Any) {
        showImage()
        clickHereButton.isHidden = true
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(StartScreen.showClickHereButton), userInfo: self, repeats: false)
    }
    
    func showImage() {
        let nRandom = Int(arc4random_uniform(2))
        if (nRandom == 0) {
            arrowView.image = #imageLiteral(resourceName: "Left_Arrow")
            
        } else {
            arrowView.image = #imageLiteral(resourceName: "Right_Arrow")
        }
        arrowView.alpha = 1.0
        UIView .animate(withDuration: 5.0) {
            self.arrowView.alpha = 0.0;
        }
    }
    
    @objc func showClickHereButton() {
        clickHereButton.isHidden = false
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

    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
