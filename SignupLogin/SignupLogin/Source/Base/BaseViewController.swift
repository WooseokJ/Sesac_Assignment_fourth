//
//  BaseViewController.swift
//  SignupLogin
//
//  Created by useok on 2022/11/02.
//

import UIKit

class BaseViewController: UIViewController {

    let baseView = BaseView()
    
    override func loadView() {
        self.view = baseView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .gray

    }
    



}
