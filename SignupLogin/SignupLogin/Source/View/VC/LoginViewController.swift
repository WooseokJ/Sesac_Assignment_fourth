//
//  MainViewController.swift
//  SignupLogin
//
//  Created by useok on 2022/11/02.
//

import UIKit

import RxSwift
import RxCocoa

final class LoginViewController: BaseViewController {
    
    // VM 가져오기
    private let loginVM = LoginViewModel()
    
    // 뷰
    private let loginView = LoginView()
    
    override func loadView() {
        super.view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "로그인 화면"
        bind()
    }
    
    private func bind() {
        
        let input = LoginViewModel.Input(signButtonTap: loginView.signupButton.rx.tap, checkButtonTap:  loginView.checkButton.rx.tap)
        let output = loginVM.transform(input: input)
        
        // 회원가입 클릭시
        output.signButtonTap
            .withUnretained(self)
            .bind { (vc,_) in
                let signupVC = SignUpViewController()
                vc.transition(signupVC, transitionStyle: .push)
            }
            .disposed(by: disposeBag)
        
        
        // 로그인 클릭시
        output.checkButtonTap
            .withUnretained(self)
            .subscribe { (vc,val) in
                
                guard let email = vc.loginView.emailTextField.text,
                      let password = vc.loginView.passwordTextField.text else {return}
                vc.api.login(email: email, password: password) { val in                    
                    if val {
                        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
                        let sceneDelegate = windowScene?.delegate as? SceneDelegate
                        let vc = ProfileViewController()
                        let nav = UINavigationController(rootViewController: vc)
                        sceneDelegate?.window?.rootViewController = nav
                        sceneDelegate?.window?.makeKeyAndVisible()
                    } else {
                        self.showAlertMessage(title: "로그인 실패")
                    }
                }
            }
            .disposed(by: disposeBag)
        
 
        
        
    }
}
