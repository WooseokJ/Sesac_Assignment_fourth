//
//  News.swift
//  week1617
//
//  Created by useok on 2022/10/20.
//

import Foundation

struct News {
    // 데이터 모델
    struct NewsItem: Hashable {
        let title: String
        let date: Date
        let body: String
        let identifier = UUID()

        init(title: String, date: DateComponents, body: String) {
            self.title = title
            self.date = DateComponents(calendar: Calendar.current,year: date.year,month: date.month,day: date.day).date!
            self.body = body
        }
    }
    // 초기값 items에 들어감.
    static var items: [NewsItem] = {
       return itemsInternal()
    }()

}

extension News {
    private static func itemsInternal() -> [NewsItem] {
        return [ NewsItem(title: "title",date: DateComponents(year: 2019, month: 3, day: 14), body: "body")]
    }
}
