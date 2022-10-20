//
//  differbleViewModel.swift
//  week1617
//
//  Created by useok on 2022/10/20.
//

import Foundation

class differbleViewModel {
    var photoList: COservable<SearchPhoto> = COservable(SearchPhoto(total: 0, totalPages: 0, results: []))
    
    func requestSearchPhoto(query: String) {
        APIService.searchPhoto(query: query) { photo, statusCode, error in
            guard let photo = photo else {return}
            self.photoList.value = photo
        } // APIService 에서 대신해줘 하고 받은거 사용
    }
    
}
