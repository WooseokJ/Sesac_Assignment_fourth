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
    
//    typealias completion = (ListPhoto?, ListError?) -> Void
    
//    static func listPhoto(page: String, completion: @escaping completion ) {
//        //MARK: Main Thread
//        
//        let url = URL(string:"\(APIKey.searchURL)\(page)")
//        
//        URLSession.shared.dataTask(with: url!) { data, response, error in
//            DispatchQueue.main.async {
//                //문제 확인
//                guard error == nil else {
//                    print("failed request")
//                    completion(nil,.failRequest) //정상적인경우 nil, 실패시 failrequest
//                    return
//                    
//                }
//                guard let data = data else {
//                    print("no data return")
//                    completion(nil,.noData)
//                    return
//                    
//                }
//                guard let response = response as? HTTPURLResponse else {
//                    print("unable response")
//                    completion(nil,.invaliResponse)
//                    return
//                    
//                } // URLSession을 HTTPURLResponse로 타입캐스팅할떄 문제있는지 판단.
//                guard response.statusCode == 200 else {
//                    print("failed response")
//                    completion(nil,.failRequest)
//                    return
//                    
//                }
//                // 에러코드가 안나는지 판단.
//                
//                //예외처리해줫으므로 이제부터 구현
//                do {
//                    let result = try JSONDecoder().decode(ListPhoto.self, from: data)
//                    print("result:",result)
//                    
//                    completion(result,nil)
//                } catch {
//                    print("error",error)
//                    completion(nil, .invalidData)
//                }
//            }
//        }.resume() //resume이 요청을 실제로 해달라!
//    }
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
