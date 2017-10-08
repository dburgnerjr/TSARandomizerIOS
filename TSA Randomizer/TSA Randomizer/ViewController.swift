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

class ViewController: UIViewController, GADBannerViewDelegate, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        let count : Int = response.products.count
        if (count > 0) {
            let validProduct: SKProduct = response.products[0] as SKProduct
            if (validProduct.productIdentifier == self.product_id) {
                print(validProduct.localizedTitle)
                print(validProduct.localizedDescription)
                print(validProduct.price)
                buyProduct(product: validProduct);
            } else {
                print(validProduct.productIdentifier)
            }
        } else {
            print("nothing")
        }
    }

    func request(_ request: SKRequest, didFailWithError error: Error) {
        print("Error Fetching product information");
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction:AnyObject in transactions {
            if let trans:SKPaymentTransaction = transaction as? SKPaymentTransaction{
                switch trans.transactionState {
                case .purchased:
                    print("Product Purchased");
                    SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
                    // Handle the purchase
                    UserDefaults.standard.set(true , forKey: "purchased")
                    hideBanner(adMobBannerView)
                    break;
                    
                case .failed:
                    print("Purchased Failed");
                    SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
                    break;
                    
                case .restored:
                    print("Already Purchased");
                    SKPaymentQueue.default().restoreCompletedTransactions()
                    // Handle the purchase
                    UserDefaults.standard.set(true , forKey: "purchased")
                    hideBanner(adMobBannerView)
                    break;
                    
                default:
                    break;
                }
            }
        }
    }
    
    
    // Ad banner and interstitial views
    var adMobBannerView = GADBannerView()
    
    var product_id: String?

    @IBOutlet weak var removeAdsButton: UIButton!
    // IMPORTANT: REPLACE THE RED STRING BELOW WITH THE AD UNIT ID YOU'VE GOT BY REGISTERING YOUR APP IN http://apps.admob.com
    let ADMOB_BANNER_UNIT_ID = "ca-app-pub-9733347540588953/7805958028"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Init AdMob banner
        initAdMobBanner()
        product_id = "com.dburgnerjr.TSARandomizer.tsa_randomizer_remove_ads"
        //removeAdsButton.isHidden = true
        SKPaymentQueue.default().add(self)
        
        //Check if product is purchased
        if (UserDefaults.standard.bool(forKey: "purchased")) {
            // Hide ads
            hideBanner(adMobBannerView)
        } else {
            showBanner(adMobBannerView)
        }
    }

    @IBAction func aboutButton(_ sender: Any) {
        let AboutVC = self.storyboard?.instantiateViewController(withIdentifier: "aboutVC")
        self.present(AboutVC!, animated: true, completion: nil)
    }
    
    @IBAction func startButton(_ sender: Any) {
        let StartVC = self.storyboard?.instantiateViewController(withIdentifier: "startVC")
        self.present(StartVC!, animated: true, completion: nil)
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
        //let alertController = UIAlertController(title: "Coming soon!", message:
        //    "To this app.", preferredStyle: UIAlertControllerStyle.alert)
        //alertController.addAction(UIAlertAction(title: "OK", style:
        //    UIAlertActionStyle.default, handler:nil))
        //present(alertController, animated: true, completion: nil)
        // Can make payments
        if (SKPaymentQueue.canMakePayments())
        {
            let productID:NSSet = NSSet(object: self.product_id!);
            let productsRequest:SKProductsRequest = SKProductsRequest(productIdentifiers: productID as! Set<String>);
            productsRequest.delegate = self;
            productsRequest.start();
            print("Fetching Products");
        }else{
            print("Can't make purchases");
        }
    }

    func buyProduct(product: SKProduct){
        let payment = SKPayment(product: product)
        SKPaymentQueue.default().add(payment);
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

