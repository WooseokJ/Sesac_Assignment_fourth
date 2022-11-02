//
//  PersonAPIManager.swift
//  Unsplash
//
//  Created by useok on 2022/10/31.
//

import Foundation

class PersonAPIManager {
    static func requestPerson(query: String, completion: @escaping (Person?,APIError?) -> Void) {
        ///        let scheme = "https"
        ///        let host = "api.thmoviedb.org" //공통영역
        ///        let path = "/3/search/person" //세부항목
        ///        let language = "ko-KR"
        ///        let key = "f489dc25fbe453f2a6afaf7b182defd5"
        ///
        
        let url = URL(string: "https://api.themoviedb.org/3/search/person?api_key=f489dc25fbe453f2a6afaf7b182defd5&language=en-US&query=\(query)&page=1&include_adult=false&region=ko-KR")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in

            DispatchQueue.main.async {
                //문제 확인
                guard error == nil else {
                    print("failed request")
                    completion(nil,.failRequest) //정상적인경우 nil, 실패시 failrequest
                    return
                    
                }
                guard let data = data else {
                    print("no data return")
                    completion(nil,.noData)
                    return
                    
                }
                guard let response = response as? HTTPURLResponse else {
                    print("unable response")
                    completion(nil,.invaliResponse)
                    return
                    
                } // URLSession을 HTTPURLResponse로 타입캐스팅할떄 문제있는지 판단.
                guard response.statusCode == 200 else {
                    print("failed response")
                    completion(nil,.failRequest)
                    return
                    
                }
                // 에러코드가 안나는지 판단.
                
                //예외처리해줫으므로 이제부터 구현
                do {
                    let result = try JSONDecoder().decode(Person.self, from: data)
                    print("result:",result)
                    completion(result,nil)
                } catch {
                    print("error",error)
                    completion(nil,.invalidata)
                }
            }
        }.resume() //resume이 요청을 실제로 해달라!
        

    }
}
