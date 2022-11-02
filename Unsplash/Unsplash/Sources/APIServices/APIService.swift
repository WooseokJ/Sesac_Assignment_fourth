//
//  APIService.swift
//  Unsplash
//
//  Created by useok on 2022/10/31.
//

import Foundation
import Alamofire

enum ListError: Error {
    case invaliResponse
    case noData
    case invalidData
    case failRequest
}

class APIService {
    
    typealias completion = (ListPhoto?,Int?,ListError?) -> Void

    static func searchPhoto(query: String, completion: @escaping completion) {
        let url = "\(APIKey.searchURL)\(query)"
        let header: HTTPHeaders = ["Authorization": APIKey.authorization]

        AF.request(url,method: .get,headers: header).responseDecodable(of: ListPhoto.self) { response in
            let statusCode = response.response?.statusCode //상태코드 조건문처리시 사용
            switch response.result {
                case .success(let value):
                    print(value)
                    completion(value, statusCode, nil)

                case .failure(let error):
                    print(error)
                completion(nil, statusCode, ListError.failRequest)
            }
        }
    }
    private init() {}
}
