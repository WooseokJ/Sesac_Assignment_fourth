//
//  MainViewModel.swift
//  SignupLogin
//
//  Created by useok on 2022/11/02.
//

import Foundation
import RxSwift
import RxCocoa

final class LoginViewModel {
    
    struct Input {
        let signButtonTap: ControlEvent<Void> // loginView.signupButton.rx.tap
        let checkButtonTap: ControlEvent<Void> //    loginView.checkButton.rx.tap
    }
    
    struct Output {
        let signButtonTap: ControlEvent<Void>
        let checkButtonTap: ControlEvent<Void>
    }
    
    func transform(input: Input) -> Output {
        return Output(signButtonTap: input.signButtonTap, checkButtonTap: input.checkButtonTap)
    }

}
