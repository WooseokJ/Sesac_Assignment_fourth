//
//  NewsViewModel.swift
//  week1617
//
//  Created by useok on 2022/10/20.
//

import Foundation


// import UIKit 은 하지말자  ViewModel이므로 로직에대한것만 넣자.
// 로직, 초기화, 네트워크
class NewsViewModel {
    var pageNumber: COservable<String> = COservable("3000")


    var sample: COservable<[News.NewsItem]> = COservable(News.items) //타입은 [News.NewsItem]이라는 타입
                                                                    // 초기화는 News.items 가 초기값
    
    func chagePageNumberFormat(text: String) { // 예를 들어 333,333이면 guard let number쪽에서 3,3333은 Int형 변환이 안되므로 else구문 타서 안되는거
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal // decimal: 1243 -> 1,243으로 바꿔주자(실제로 바뀌진않음)
        let text = text.replacingOccurrences(of: ",", with: "")
        guard let number = Int(text) else {return} // String -> Int형으로 변환
        let result = numberFormatter.string(from: number as NSNumber)! // number 의 값 int형 1,243바꾼뒤 result 저장
        pageNumber.value = result
    }
    func resetSample() {
        sample.value = []
    }
    func loadSample() {
        sample.value = News.items
    }

}

//MARK: RX사용
//import RxSwift
//class NewsViewModel {
//    var pageNumber = BehaviorSubject<String>(value: "3,000")
//
//
//    var sample = BehaviorSubject(value: News.items)
//
//    func chagePageNumberFormat(text: String) { // 예를 들어 333,333이면 guard let number쪽에서 3,3333은 Int형 변환이 안되므로 else구문 타서 안되는거
//        let numberFormatter = NumberFormatter()
//        numberFormatter.numberStyle = .decimal // decimal: 1243 -> 1,243으로 바꿔주자(실제로 바뀌진않음)
//        let text = text.replacingOccurrences(of: ",", with: "")
//        guard let number = Int(text) else {return} // String -> Int형으로 변환
//        let result = numberFormatter.string(from: number as NSNumber)! // number 의 값 int형 1,243바꾼뒤 result 저장
//        pageNumber.onNext(result) // pageNumber.on(.next(result))와 동일
//
//    }
//    func resetSample() {
//        sample.onNext([])
//
//    }
//    func loadSample() {
//        sample.onNext(News.items)
//    }
//
//}

//MARK: RX사용
//import RxCocoa
//
//class NewsViewModel {
//    var pageNumber = BehaviorRelay<String>(value: "3,000")
//
//    var sample = BehaviorRelay(value: News.items) // error와 completed가 없는상황을 만든다.
//
//    func chagePageNumberFormat(text: String) { // 예를 들어 333,333이면 guard let number쪽에서 3,3333은 Int형 변환이 안되므로 else구문 타서 안되는거
//        let numberFormatter = NumberFormatter()
//        numberFormatter.numberStyle = .decimal // decimal: 1243 -> 1,243으로 바꿔주자(실제로 바뀌진않음)
//        let text = text.replacingOccurrences(of: ",", with: "")
//        guard let number = Int(text) else {return} // String -> Int형으로 변환
//        let result = numberFormatter.string(from: number as NSNumber)! // number 의 값 int형 1,243바꾼뒤 result 저장
//        pageNumber.accept(result) // pageNumber.on(.next(result))와 동일
//
//    }
//    func resetSample() {
//        sample.accept([])
//    }
//    func loadSample() {
//        sample.accept(News.items)
//    }
//
//}
