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

class ViewController: UIViewController, GADBannerViewDelegate, SKPaymentTransactionObserver, SKProductsRequestDelegate {
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
                case SKPaymentTransactionState.purchased:
                            SKPaymentQueue.default().finishTransaction(transaction)
                            bannerView.isHidden = true
                            removeAdsButton.isEnabled = false
                            removeAdsButton.isHidden = true
                            restorePurchasesButton.isHidden = true
                            let save = UserDefaults.standard
                            save.set(true, forKey: "Purchase")
                            save.synchronize()

                case SKPaymentTransactionState.restored:
                            SKPaymentQueue.default().finishTransaction(transaction)
                            bannerView.isHidden = true
                            removeAdsButton.isEnabled = false
                            removeAdsButton.isHidden = true
                            restorePurchasesButton.isHidden = true
                            let save = UserDefaults.standard
                            save.set(true, forKey: "Purchase")
                            save.synchronize()

                case SKPaymentTransactionState.failed:
                            SKPaymentQueue.default().finishTransaction(transaction)
                            let alertController = UIAlertController(title: "Warning!", message:
                                "The product has not been purchased", preferredStyle: UIAlertControllerStyle.alert)
                            alertController.addAction(UIAlertAction(title: "OK", style:
                                UIAlertActionStyle.default, handler:nil))
                            present(alertController, animated: true, completion: nil)
                default:
                            break
            }
        }
    }
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        var products = response.products
        
        if (products.count == 0) {
            let alertController = UIAlertController(title: "Warning!", message:
                "No products available", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "OK", style:
                UIAlertActionStyle.default, handler:nil))
            present(alertController, animated: true, completion: nil)
        } else {
            product = products[0]
            removeAdsButton.isEnabled = true
        }
        let invalid = response.invalidProductIdentifiers
        for product in invalid {
            print("product not found: \(product)" )
        }
    }
    
    
    @IBOutlet weak var bannerView: GADBannerView!
    @IBOutlet weak var removeAdsButton: UIButton!
    @IBOutlet weak var restorePurchasesButton: UIButton!
    
    var product: SKProduct?
    var productID = "com.dburgnerjr.TSARandomizer.removeads"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        bannerView.isHidden = true
        bannerView.delegate = self
        
        removeAdsButton.isEnabled = false
        SKPaymentQueue.default().add(self)
        getPurchaseInfo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Check if product is purchased
        let save = UserDefaults.standard
        if (save.value(forKey: "Purchase") == nil) {
            bannerView.adUnitID = "ca-app-pub-9733347540588953/7805958028"
            bannerView.adSize = kGADAdSizeSmartBannerPortrait
            bannerView.rootViewController = self
            bannerView.load(GADRequest())
        } else {
            bannerView.isHidden = true
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
            let payment = SKPayment(product: product!)
            SKPaymentQueue.default().add(payment)
    }

    @IBAction func restorePurchasesButton(_ sender: Any) {
            SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
    func getPurchaseInfo() {
        if SKPaymentQueue.canMakePayments() {
            let request = SKProductsRequest(productIdentifiers: NSSet(objects: self.productID) as! Set<String>)
            request.delegate = self
            request.start()
        } else {
            let alertController = UIAlertController(title: "Warning!", message:
                "Please enable in app purchases in your settings.", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "OK", style:
                UIAlertActionStyle.default, handler:nil))
            present(alertController, animated: true, completion: nil)
        }
    }
    
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

