//
//  MainView.swift
//  SignupLogin
//
//  Created by useok on 2022/11/02.
//

import UIKit
import SnapKit

final class SignupView: BaseView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        setConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var emailSignupTextField: UITextField = {
        let textfield = UITextField()
        textfield.backgroundColor = Color.textFieldBackGround
        textfield.placeholder = "@,.com을 포함하는 email 입력해주세요"
        return textfield
    }()
  
    lazy var passwordSignupTextField: UITextField = {
        let textfield = UITextField()
        textfield.backgroundColor = Color.textFieldBackGround
        textfield.placeholder = " 8글자이상의 password 입력해주세요"
        return textfield
    }()
    
    lazy var nicknameSignupTextField: UITextField = {
        let textfield = UITextField()
        textfield.backgroundColor = Color.textFieldBackGround
        textfield.placeholder = " nickanme 입력해주세요"
        return textfield
    }()
    
    lazy var checkSignupButton: UIButton = {
        let bt = UIButton()
        bt.backgroundColor = .lightGray
        bt.setTitle("확인", for: .normal)
        return bt
    }()
    
    
    override func configure() {
        [emailSignupTextField,passwordSignupTextField,nicknameSignupTextField,checkSignupButton].forEach{
            self.addSubview($0)
        }
    }
    
    override func setConstrains() {
        emailSignupTextField.snp.makeConstraints {
            $0.top.equalTo(150)
            $0.leading.equalTo(20)
            $0.trailing.equalTo(-20)
            $0.height.equalTo(40)
        }
        
        passwordSignupTextField.snp.makeConstraints {
            $0.top.equalTo(emailSignupTextField.snp.bottom).offset(50)
            $0.leading.equalTo(emailSignupTextField.snp.leading)
            $0.trailing.equalTo(emailSignupTextField.snp.trailing)
            $0.height.equalTo(emailSignupTextField.snp.height)
        }
        
        nicknameSignupTextField.snp.makeConstraints {
            $0.top.equalTo(passwordSignupTextField.snp.bottom).offset(50)
            $0.leading.equalTo(passwordSignupTextField.snp.leading)
            $0.trailing.equalTo(passwordSignupTextField.snp.trailing)
            $0.height.equalTo(passwordSignupTextField.snp.height)
        }
        
        checkSignupButton.snp.makeConstraints {
            $0.top.equalTo(nicknameSignupTextField.snp.bottom).offset(50)
            $0.trailing.equalTo(nicknameSignupTextField.snp.trailing)
            $0.width.equalTo(nicknameSignupTextField.snp.width)
            $0.height.equalTo(nicknameSignupTextField.snp.height)
        }
    }
    
    
}
