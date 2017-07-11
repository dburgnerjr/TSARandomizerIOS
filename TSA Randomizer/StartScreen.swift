//
//  StartScreen.swift
//  TSA Randomizer
//
//  Created by Daniel Burgner on 7/11/17.
//  Copyright © 2017 Daniel Burgner. All rights reserved.
//

import UIKit

class StartScreen: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @IBAction func backButton(_ sender: Any) {
        let MainVC = self.storyboard?.instantiateViewController(withIdentifier: "mainVC")
        self.present(MainVC!, animated: true, completion: nil)
    }
    
}
