//
//  MainView.swift
//  SignupLogin
//
//  Created by useok on 2022/11/02.
//

import UIKit
import SnapKit

class ProfileView: BaseView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        setConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let title: UILabel = {
        let label = UILabel()
        label.text = "프로필 정보"
        return label
    }()
    
    
    override func configure() {
        [title].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstrains() {
        title.snp.makeConstraints {
            $0.top.equalTo(30)
            $0.centerX.equalTo(self)
            $0.height.equalTo(50)
        }
    }
    
    
}
