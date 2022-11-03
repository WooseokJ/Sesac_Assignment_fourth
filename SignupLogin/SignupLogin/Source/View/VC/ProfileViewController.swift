//
//  ProfileViewController.swift
//  SignupLogin
//
//  Created by useok on 2022/11/02.
//

import UIKit
import RxSwift
import RxCocoa

final class ProfileViewController: BaseViewController {

    private let profileView = ProfileView()
    
    override func loadView() {
        self.view = profileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "프로필 정보"
        bind()
        


       
    }
    
    private func bind() {
       
        api.profile { [weak self] val in
            self?.profileView.email.text = "Email: " + (val?.user.email ?? "No Email")
            self?.profileView.nickname.text = "NickName: " + (val?.user.username ?? "No NickName")
        }
        
        
        // 로그아웃 버튼클릭시
        profileView.logutButton.rx.tap
            .withUnretained(self)
            .bind { (vc,val) in
                UserDefaults.standard.set(nil, forKey: "token")
                let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
                let sceneDelegate = windowScene?.delegate as? SceneDelegate
                let vc = LoginViewController()
                let nav = UINavigationController(rootViewController: vc)
                sceneDelegate?.window?.rootViewController = nav
                sceneDelegate?.window?.makeKeyAndVisible()
            }
            .disposed(by: disposeBag)
        
    }

  

}
