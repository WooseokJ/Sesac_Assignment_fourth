//
//  MainViewController.swift
//  SignupLogin
//
//  Created by useok on 2022/11/02.
//

import UIKit

import RxSwift
import RxCocoa

class LoginViewController: BaseViewController {

    // VM 가져오기
    let loginVM = LoginViewModel()

    // 구독해제
    let disposeBag = DisposeBag()
    


    // 뷰
    let loginView = LoginView()
    override func loadView() {
        super.view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "로그인 화면"
        
        // test
//        api.signup(username: "testing101022", email: "testing101022@naver.com", password: "testing101022")
//        api.login(email: "testing101022@naver.com", password: "testing101022")
//        api.profile()
        
        bind()
       
    }
    
    func bind() {
        
        // 유효성검사
        let validation = Observable.combineLatest(loginView.emailTextField.rx.text.orEmpty, loginView.passwordTextField.rx.text.orEmpty) { email, password in
            email.contains("@") && email.contains("com") && password.count >= 8
        }.share()
        
        
        
        // 회원가입 클릭시
        loginView.signupButton.rx.tap
            .withUnretained(self)
            .bind { (vc,_) in
                let signupVC = SignUpViewController()
                vc.transition(signupVC, transitionStyle: .push)
            }
            .disposed(by: disposeBag)
        
        
        // 로그인 클릭시 
        loginView.checkButton.rx.tap
            .withUnretained(self)
            .subscribe { (vc,_) in
                
                let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
                let sceneDelegate = windowScene?.delegate as? SceneDelegate
                let vc = ProfileViewController()
                let nav = UINavigationController(rootViewController: vc)
                sceneDelegate?.window?.rootViewController = nav
                sceneDelegate?.window?.makeKeyAndVisible()
                
            } onError: { error in
                print("error: ",error)
            } onCompleted: {
                print("completed")
            } onDisposed: {
                print("disposed")
            }
            .disposed(by: disposeBag)
    }
    
//    signupView.checkSignupButton.rx.tap
//        .withUnretained(self)
//        .subscribe { (vc,val) in
//
//            guard let email = vc.signupView.emailSignupTextField.text,
//                  let password = vc.signupView.passwordSignupTextField.text,
//                  let nickname = vc.signupView.nicknameSignupTextField.text else {return}
//            vc.api.signup(username: nickname, email: email, password: password) { val in
//                print(val)
//                if val {vc.navigationController?.popViewController(animated: true)}
//                else {
//                    self.showAlertMessage(title: "오류발생")
//                }
//            }
//
//        }
//        .disposed(by: disposeBag)
    
    
    
}
