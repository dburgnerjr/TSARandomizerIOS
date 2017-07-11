//
//  ViewController.swift
//  TSA Randomizer
//
//  Created by Daniel Burgner on 7/9/17.
//  Copyright © 2017 Daniel Burgner. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
        let alertController = UIAlertController(title: "Coming soon!", message:
            "To this app.", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style:
            UIAlertActionStyle.default, handler:nil))
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func removeAdsButton(_ sender: Any) {
        let alertController = UIAlertController(title: "Coming soon!", message:
            "To this app.", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style:
            UIAlertActionStyle.default, handler:nil))
        present(alertController, animated: true, completion: nil)
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

