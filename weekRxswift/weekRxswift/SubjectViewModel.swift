//
//  SubjectViewModel.swift
//  weekRxswift
//
//  Created by useok on 2022/10/25.
//

import Foundation
import RxSwift

struct Contact {
    var name: String
    var age: Int
    var number: String
}

class SubjectViewModel {
    
    var contactData = [
        Contact(name: "jack", age: 21, number: "01012121212"),
        Contact(name: "meta jack", age: 22, number: "01034343434"),
        Contact(name: "real jack", age: 23, number: "01056565656")
    ]
    
    var list = PublishSubject<[Contact]>()
    
    func fetchData() {
        list.onNext(contactData)
    }
    func resetData() {
        list.onNext([])
    }
    func newData() {
        let new = Contact(name: "고래밥", age: Int.random(in: 20...80), number: "010808080")
        contactData.append(new)
        list.onNext(contactData)
    }
    func filterData(query: String) {
        let filterData = query != "" ? contactData.filter {$0.name.contains(query)} : contactData
        list.onNext(filterData)
        
    }
    
}
