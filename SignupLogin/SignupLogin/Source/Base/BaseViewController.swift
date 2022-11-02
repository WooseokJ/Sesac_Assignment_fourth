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
        self.view.backgroundColor = .systemGray4

    }
    func showAlertMessage(title: String) {
        let alert = UIAlertController(title: title, message: "", preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default)
        alert.addAction(ok)
        present(alert,animated: true)
    }
    
}
