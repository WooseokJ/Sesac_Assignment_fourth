//
//  ValidationViewModel.swift
//  weekRxswift
//
//  Created by useok on 2022/10/27.
//

import Foundation
import RxSwift
import RxCocoa

class ValidationViewModel {
    
    let validText = BehaviorSubject(value: "닉네임 최소8글자 이상")
    
    
    struct Input {
        let text: ControlProperty<String?> // nameTextField.rx.text
        let tap: ControlEvent<Void> // stepButton.rx.tap
        
    }
    
    struct Output {
        let validation: Observable<Bool>  // nameTextField.rx.text.orEmpty.map{}.share()
        let tap: ControlEvent<Void>
        let text: Driver<String>
    }
    func transform(input: Input) -> Output { // input의 text -> output의 validation으로 바꾸는데 화살표영역을뜻함.
        let vaild = input.text //18 번째의 text 가져옴. , String?
            .orEmpty // 옵셔널 제거 -> String
            .map{$0.count >= 8} // 글자수판단 -> Bool
            .share() // 내부적으로 구현된부분이 Subject,Relay 가된다.
        let text = validText.asDriver(onErrorJustReturn: " ")             // drive에 error가 날순없지만 분기처리시 에러가 날수도있으므로 대응.
        return Output(validation: vaild,tap: input.tap,text: text) // vm -> vc로 전달을해줌.
        
    }
    
}
