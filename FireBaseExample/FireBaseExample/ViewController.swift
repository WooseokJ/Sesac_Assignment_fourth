//
//  ViewController.swift
//  FireBaseExample
//
//  Created by useok on 2022/10/05.
//

import UIKit
import FirebaseAnalytics

class ViewController: UIViewController {




    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Analytics.logEvent("share_image", parameters: [
            "name": "고래밥", // userdefault or realm 에서 가져와 써도되고 String값을 지정해도된다
          "full_text": "안녕",
        ])
        
        Analytics.setDefaultEventParameters([
          "level_name": "Caverns01",
          "level_difficulty": 4
        ])
        
    }
    
    @IBAction func buttonClicked(_ sender: Any) {
    }
    

}

