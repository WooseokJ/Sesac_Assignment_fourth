//
//  SignUpViewController.swift
//  SignupLogin
//
//  Created by useok on 2022/11/02.
//

import UIKit
import RxSwift
import RxCocoa

class SignUpViewController: BaseViewController {

    let signupView = SignupView()
    
    let disposeBag = DisposeBag()
    override func loadView() {
        self.view = signupView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "회원가입"
        bind()
    }
    

    func bind() {
        signupView.checkSignupButton.rx.tap
            .withUnretained(self)
            .subscribe { (vc,_) in

            }
            .disposed(by: disposeBag)
    }

}
