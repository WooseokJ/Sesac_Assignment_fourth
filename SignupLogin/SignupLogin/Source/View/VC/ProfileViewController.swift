//
//  ProfileViewController.swift
//  SignupLogin
//
//  Created by useok on 2022/11/02.
//

import UIKit
import RxSwift
import RxCocoa

class ProfileViewController: BaseViewController {

    let profileView = ProfileView()
    
    override func loadView() {
        self.view = profileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "프로필 정보"
        bind()
        
    }
    
    func bind() {
       
            
    }

  

}
