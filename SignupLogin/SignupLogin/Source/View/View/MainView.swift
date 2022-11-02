//
//  MainView.swift
//  SignupLogin
//
//  Created by useok on 2022/11/02.
//

import UIKit

import SnapKit

class MainView: BaseView {
    
    // 연결
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        setConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    let emailTextField: UITextField = {
        let textfield = UITextField()
        textfield.backgroundColor = .yellow
        textfield.placeholder = " email 입력"
        return textfield
    }()
  
    let passwordTextField: UITextField = {
        let textfield = UITextField()
        textfield.backgroundColor = .yellow
        textfield.placeholder = " password 입력"
        return textfield
    }()
    
    let checkButton: UIButton = {
        let bt = UIButton()
        bt.backgroundColor = .red
        bt.setTitle("확인", for: .normal)
        return bt
    }()
    
    let signupButton: UIButton = {
        let bt = UIButton()
        bt.backgroundColor = .red
        bt.setTitle("회원가입", for: .normal)
        return bt
    }()
    
    override func configure() {
        [emailTextField,passwordTextField,checkButton,signupButton].forEach{
            self.addSubview($0)
        }
    }
    
    override func setConstrains() {
        emailTextField.snp.makeConstraints {
            $0.top.equalTo(100)
            $0.leading.equalTo(20)
            $0.trailing.equalTo(-20)
            $0.height.equalTo(40)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(50)
            $0.leading.equalTo(emailTextField.snp.leading)
            $0.trailing.equalTo(emailTextField.snp.trailing)
            $0.height.equalTo(emailTextField.snp.height)
        }
        
        checkButton.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(50)
            $0.leading.equalTo(passwordTextField.snp.leading)
            $0.height.equalTo(60)
            $0.width.equalTo(passwordTextField.snp.width).multipliedBy(0.3)
        }
        
        signupButton.snp.makeConstraints {
            $0.top.equalTo(checkButton.snp.top)
            $0.trailing.equalTo(passwordTextField.snp.trailing)
            $0.height.equalTo(checkButton.snp.height)
            $0.width.equalTo(checkButton.snp.width)
        }
        
    }
    
    
}
