//
//  SubjectViewModel.swift
//  weekRxswift
//
//  Created by useok on 2022/10/25.
//

import Foundation
import RxSwift
import RxCocoa

// associated type == generic과 유사
protocol CommonViewModel {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}


struct Contact {
    var name: String
    var age: Int
    var number: String
}

class SubjectViewModel: CommonViewModel {
    
    var contactData = [
        Contact(name: "jack", age: 21, number: "01012121212"),
        Contact(name: "meta jack", age: 22, number: "01034343434"),
        Contact(name: "real jack", age: 23, number: "01056565656")
    ]
    
    var list = PublishSubject<[Contact]>() // 초기값없음, ui특화, 구독전에 이벤트를 전달하면? -> 전달한건 무시 
    
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
    
    
    struct Input {
        let addTap: ControlEvent<Void> // addButton.rx.tap
        let resetTap: ControlEvent<Void> //resetButton.rx.tap
        let newTap: ControlEvent<Void> //newButton.rx.tap
        let searchText: ControlProperty<String?> //searchBar.rx.text
    }
    
    struct Output {
        let addTap: ControlEvent<Void>
        let resetTap: ControlEvent<Void>
        let newTap: ControlEvent<Void>
        let list: Driver<[Contact]> //viewModel.list.asDriver(onErrorJustReturn: [])
        let searchText: Observable<String>

    }
    
    func transform(input: Input) -> Output {
        let list = list.asDriver(onErrorJustReturn: [])
        let text = input.searchText
            .orEmpty // vc->vm (input)
            .debounce(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance) //wait
            .distinctUntilChanged() //같은값 받지않음
        return Output(addTap: input.addTap, resetTap: input.resetTap, newTap: input.newTap, list: list, searchText: text)
    }

    
}

