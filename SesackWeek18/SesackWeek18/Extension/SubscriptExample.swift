//
//  SubscriptExample.swift
//  SesackWeek18
//
//  Created by useok on 2022/11/03.
//

import Foundation

extension String {
    
    //MARK: 문자열의 idx번째 글자 구하기

    // jack ->> jack[1] ->> a를 출력할거야
    subscript(idx: Int) -> String? { /// 문자열에서 index out of range 날수있으므로 nil 처리 만들어둬야해서 옵셔널
        
        guard (0..<count).contains(idx) else {return nil}// string이라서 self.count인데 self는 생략
              
        let result = index(startIndex, offsetBy: 3) // 첫번쨰기준으로 3번쨰떨어진 글자 를 result에담기
        return String(self[result])
    }
}

extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}


// let a = [Phone() , Phone() ]
struct Phone {
    
    var numbers = ["0000","1111","2222","3333"] // Realm <Todo>! 이면 아래 String대신 Todo 로
    
    subscript(idx: Int) -> String {
        get {
            self.numbers[idx]
        }
        set {
            self.numbers[idx] = newValue
        }
    }
    
    
}

