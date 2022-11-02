//
//  Observable.swift
//  Unsplash
//
//  Created by useok on 2022/10/31.
//

import Foundation

class Oservable<T> {
    
    private var listener: ((T) -> Void)?
    
    var value: T { //model
        didSet { // viewModel
            listener?(value)  // value(데이터)바뀌면 -> listener(화면뷰)가 label.text 바뀌게됨. ,
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ com: @escaping (T)->Void) {
        com(value) // 클로저(com) 로직 실행
        listener = com // 클로저(com)함수의 로직자체를 담는다.
    }

}
