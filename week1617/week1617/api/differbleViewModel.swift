

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

//import RxSwift
//
//enum SearchError: Error {
//    case noPhoto
//    case serverError
//}
//
//class differbleViewModel {
//    var photoList = PublishSubject<SearchPhoto>()
//
//    func requestSearchPhoto(query: String) {
//        APIService.searchPhoto(query: query) { [weak self] photo, statusCode, error in
//            /// 이렇게 error를 보내면 dispose가 되므로 다음두가지 방법에 대처해야한다.
//            /// 방법1. 다시 구독하기
//            /// 방법2. Trait을 활용하기
//            guard let statusCode = statusCode, statusCode == 200  else { //, statusCode == 500 이거를하면 else문 탄다 .
//                self?.photoList.onError(SearchError.serverError)
//                return
//            }
//
//            guard let photo = photo else {
//                self?.photoList.onError(SearchError.noPhoto) //photo 받아오는게 실패할떄 에러이벤트를 보낸다
//                return
//            }
//            self?.photoList.onNext(photo)
////            self?.photoList.onCompleted()
//        } // APIService 에서 대신해줘 하고 받은거 사용
//    }
//
//}
