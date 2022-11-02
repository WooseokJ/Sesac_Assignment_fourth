//
//  CObservable.swift
//  week1617
//
//  Created by useok on 2022/10/20.
//

import Foundation


class COservable<T> {
    
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
    
    
    // 순서1
//    viewmodel.pageNumber.bind { [self] val in
//        numberTextField.text = val
//    } // com은 해당 클로저안의 로직을 listener에 담는다.
    //순서2
//    private var listener: ((T) -> Void)? = { [self] val in
        //        numberTextField.text = val
        //    }
    //로 담긴다.
    //순서3
//    value값이 바뀌면 listener?(value) 실행되므로 순서2에있는게 실행.

}
