//
//  MainViewModel.swift
//  Unsplash
//
//  Created by useok on 2022/10/31.
//

import Foundation
import RxSwift

class MainViewModel {
    var photoList = PublishSubject<ListPhoto>()
    
    
    func requestPhoto(page: String) {
        APIService.searchPhoto(query: page) { [weak self] photo,statusCode,error in
            guard let statusCode = statusCode else {
                self?.photoList.onError(ListError.failRequest)
                return
            }
            guard let photo = photo else {
                self?.photoList.onError((ListError.failRequest))
                return
            }
            self?.photoList.onNext(photo)
        }
    }
    
}
