//
//  ViewController.swift
//  SesackWeek18
//
//  Created by useok on 2022/11/02.
//

import UIKit

class ViewController: UIViewController {

    let api = APIService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        api.signup()
//        api.login()
        api.profile()
    }


}

