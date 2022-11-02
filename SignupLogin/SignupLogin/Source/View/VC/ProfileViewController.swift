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
        

        // 10 초후 token 만료
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            UserDefaults.standard.set(nil, forKey: "token")
        }
        
    }
    
    private func bind() {
       
        api.profile { [weak self] val in
            self?.profileView.email.text = "Email: " + (val?.user.email ?? "No Email")
            self?.profileView.nickname.text = "NickName: " + (val?.user.username ?? "No NickName")
        }
        
    }

  

}
