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
    let mainViewModel = MainViewModel()

    // 구독해제
    let disposeBag = DisposeBag()
    
    // 네트워크
    let api = APIService()

    // 뷰
    let mainView = MainView()
    override func loadView() {
        super.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "로그인 화면"
        
        // test
//        api.signup(username: "testing101022", email: "testing101022@naver.com", password: "testing101022")
//        api.login(email: "testing101022@naver.com", password: "testing101022")
        api.profile()
        
        bind()
       
    }
    
    func bind() {
        
        mainView.signupButton.rx.tap
            .withUnretained(self)
            .bind { (vc,_) in
                let signupVC = SignUpViewController()
                vc.transition(signupVC, transitionStyle: .push)
            }
            .disposed(by: disposeBag)
        
        
        mainView.checkButton.rx.tap
            .withUnretained(self)
            .subscribe { (vc,_) in
                let profileVC = ProfileViewController()
                vc.transition(profileVC, transitionStyle: .present)
            } onError: { error in
                print("error: ",error)
            } onCompleted: {
                print("completed")
            } onDisposed: {
                print("disposed")
            }
            .disposed(by: disposeBag)
    }
    
    
    

 
}
