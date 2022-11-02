//
//  SignupViewModel.swift
//  SignupLogin
//
//  Created by useok on 2022/11/02.
//

import Foundation
import RxSwift

class SignupViewModel {
    
    // 네트워크
    let api = APIService()
    
    let emailValid = BehaviorSubject(value: "이메일 형식을 지켜주세요")
    let passwordValid = BehaviorSubject(value: "8글자 이상 써주세요.")
}
