//
//  StartScreen.swift
//  TSA Randomizer
//
//  Created by Daniel Burgner on 7/11/17.
//  Copyright © 2017 Daniel Burgner. All rights reserved.
//

import UIKit

class StartScreen: UIViewController {
    
    @IBOutlet weak var arrowView: UIImageView!
    @IBOutlet weak var clickHereButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        clickHereButton.addTarget(self, action: #selector(StartScreen.buttonClicked(_:)), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func buttonClicked(_ sender: Any) {
        //clickHereButton.isHidden = true
        let nRandom = Int(arc4random_uniform(2))
        if (nRandom == 0) {
            arrowView.image = #imageLiteral(resourceName: "Left_Arrow")
        } else {
            arrowView.image = #imageLiteral(resourceName: "Right_Arrow")
        }
        //clickHereButton.isHidden = false
    }
    
    @IBAction func backButton(_ sender: Any) {
        let MainVC = self.storyboard?.instantiateViewController(withIdentifier: "mainVC")
        self.present(MainVC!, animated: true, completion: nil)
    }
    
}
