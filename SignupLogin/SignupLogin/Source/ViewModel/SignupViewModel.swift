//
//  SignupViewModel.swift
//  SignupLogin
//
//  Created by useok on 2022/11/02.
//

import Foundation
import RxSwift
import RxCocoa

class SignupViewModel {
    
    struct Input {
        let checkTap: ControlEvent<Void> // signupView.checkSignupButton.rx.tap
        
    }
    
    struct Output {
        let checkTap: ControlEvent<Void>
    }
    
    func transform(input: Input) -> Output {
        return Output(checkTap: input.checkTap)
    }

}
