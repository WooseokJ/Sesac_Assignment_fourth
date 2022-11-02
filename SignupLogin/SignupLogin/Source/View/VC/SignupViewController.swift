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
    
    var signupView = SignupView()
    
    let signupViewModel = SignupViewModel()
    
    // 네트워크
    let api = APIService()
    
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
        
        let validation = Observable.combineLatest(signupView.emailSignupTextField.rx.text.orEmpty, signupView.passwordSignupTextField.rx.text.orEmpty, signupView.nicknameSignupTextField.rx.text.orEmpty) { email, password, nickname in
            email.contains("@") && email.contains("com") && password.count >= 8 && !nickname.isEmpty
        }.share()
        
        validation
            .bind(to: signupView.checkSignupButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        
        
        validation
            .withUnretained(self)
            .bind { (vc,val) in
                let color: UIColor = val ? .red : .lightGray
                vc.signupView.checkSignupButton.backgroundColor = color
            }
            .disposed(by: disposeBag)
        
        signupView.checkSignupButton.rx.tap
            .withUnretained(self)
            .subscribe { (vc,val) in
                guard let email = vc.signupView.emailSignupTextField.text,
                      let password = vc.signupView.passwordSignupTextField.text,
                      let nickname = vc.signupView.nicknameSignupTextField.text else {return}
                vc.api.signup(username: nickname, email: email, password: password) { val in
                    print(val)
                    if val {vc.navigationController?.popViewController(animated: true)}
                }
            } onError: { error in
                print("error",error)
            } onCompleted: {
                print("completed")
            } onDisposed: {
                print("disposed")
            }
            .disposed(by: disposeBag)
        
    }
    
}
