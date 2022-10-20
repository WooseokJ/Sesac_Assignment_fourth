//
//  NewsViewModel.swift
//  week1617
//
//  Created by useok on 2022/10/20.
//

import Foundation
// import UIKit 은 하지말자

class NewsViewModel {
    var pageNumber: COservable<String> = COservable("3000")
    
    var sample: COservable<[News.NewsItem]> = COservable(News.items)
    
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
