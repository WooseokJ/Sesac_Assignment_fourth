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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var email: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var nickname: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override func configure() {
        [email,nickname].forEach {
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
    }
    
    
}
