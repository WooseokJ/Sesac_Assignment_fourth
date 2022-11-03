//
//  MainView.swift
//  SignupLogin
//
//  Created by useok on 2022/11/02.
//

import UIKit
import SnapKit

final class ProfileView: BaseView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        setConstrains()
    }
    
    
    lazy var email: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var nickname: UILabel = {
        let label = UILabel()
        return label
    }()
    

    
    lazy var logutButton: UIButton = {
        let bt = UIButton()
        bt.setTitle("로그아웃", for: .normal)
        bt.backgroundColor = .red
        return bt
    }()
    
    override func configure() {
        [email,nickname,logutButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstrains() {
        
        email.snp.makeConstraints {
            $0.top.equalTo(100)
            $0.leading.equalTo(20)
            $0.trailing.equalTo(-20)
            $0.height.equalTo(50)
        }
        
        nickname.snp.makeConstraints {
            $0.top.equalTo(email.snp.bottom).offset(30)
            $0.leading.equalTo(email.snp.leading)
            $0.trailing.equalTo(email.snp.trailing)
            $0.height.equalTo(email.snp.height)
        }
        
        logutButton.snp.makeConstraints {
            $0.top.equalTo(nickname.snp.bottom).offset(30)
            $0.leading.equalTo(nickname.snp.leading)
            $0.trailing.equalTo(nickname.snp.trailing)
            $0.height.equalTo(nickname.snp.height)
        }

        
        
    }
    
    
}
