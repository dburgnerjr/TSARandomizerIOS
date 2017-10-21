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
    @IBOutlet weak var bannerView: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        bannerView.isHidden = true
        bannerView.delegate = self
        bannerView.adUnitID = "ca-app-pub-9733347540588953/7805958028"
        bannerView.adSize = kGADAdSizeSmartBannerPortrait
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        
//        //Check if product is purchased
//        if (UserDefaults.standard.bool(forKey: "purchased")) {
//            // Hide ads
//            adMobBannerView.isHidden = true
//        } else {
//            showBanner(adMobBannerView)
//        }

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
    
    // AdMob banner available
    func adViewDidReceiveAd(_ view: GADBannerView) {
        bannerView.isHidden = false
    }
    
    // NO AdMob banner available
    func adView(_ view: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        bannerView.isHidden = true
    }

    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
