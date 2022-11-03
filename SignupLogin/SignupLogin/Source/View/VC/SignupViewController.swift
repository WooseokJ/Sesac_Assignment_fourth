//
//  SignUpViewController.swift
//  SignupLogin
//
//  Created by useok on 2022/11/02.
//

import UIKit
import RxSwift
import RxCocoa

final class SignUpViewController: BaseViewController {
    
    private var signupView = SignupView()
    private let signupViewModel = SignupViewModel()
    
    override func loadView() {
        self.view = signupView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "회원가입"
        bind()
    }
    
    
    private func bind() {
        
        //MARK: 유효성검사 (이메일 조건,비번개수,닉네임입력여부)
        
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
        
        //MARK: input,output으로 뺴두기
        let input = SignupViewModel.Input(checkTap: signupView.checkSignupButton.rx.tap)
        let output = signupViewModel.transform(input: input)
        
        output.checkTap
            .withUnretained(self)
            .subscribe { (vc,val) in
                guard let email = vc.signupView.emailSignupTextField.text,
                      let password = vc.signupView.passwordSignupTextField.text,
                      let nickname = vc.signupView.nicknameSignupTextField.text else {return}
                vc.api.signup(username: nickname, email: email, password: password) { val in
                    if val {vc.navigationController?.popViewController(animated: true)}
                    else { vc.showAlertMessage(title: "기존에 있는 회원입니다.")}
                }
            } onError: { error in
                self.showAlertMessage(title: "오류발생")
            } onCompleted: {
                print("completed")
            } onDisposed: {
                print("disposed")
            }
            .disposed(by: disposeBag)
        
    }
    
}
