//
//  APIService.swift
//  week1617
//
//  Created by useok on 2022/10/20.
//

import Foundation
import Alamofire


class APIService {
    static func searchPhoto(query: String, completion: @escaping (SearchPhoto?, Int?, Error?) -> Void) { 
        let url = "\(APIKey.searchURL)\(query)"
        print(url)
        let header: HTTPHeaders = ["Authorization": APIKey.authorization]
        
        AF.request(url,method: .get,headers: header).responseDecodable(of: SearchPhoto.self) { response in
            let statusCode = response.response?.statusCode //상태코드 조건문처리시 사용
            switch response.result {
                case .success(let value):
                    print("====33333333=")
                    print(value)
                    completion(value, statusCode, nil)
                
                case .failure(let error):
                    print(error)
                    completion(nil, statusCode, error)
            }
        }
        
        
    }
    private init() {}
    
    
    
}
