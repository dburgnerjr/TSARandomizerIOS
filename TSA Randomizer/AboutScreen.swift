//
//  AboutScreen.swift
//  TSA Randomizer
//
//  Created by Daniel Burgner on 7/11/17.
//  Copyright © 2017 Daniel Burgner. All rights reserved.
//

import UIKit

class AboutScreen: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func storyButton(_ sender: Any) {
        let url = URL(string: "http://www.geek.com/apps/tsa-paid-1-4-million-for-randomizer-app-that-chooses-left-or-right-1651337/")!
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
