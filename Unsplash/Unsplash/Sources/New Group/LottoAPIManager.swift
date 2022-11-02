//
//  LottoAPIManager.swift
//  Unsplash
//
//  Created by useok on 2022/10/29.
//

import Foundation

enum APIError: Error {
    case invaliResponse
    case noData
    case failRequest
    case invalidata
}

class LottoAPIManager {
    static func requestLotto(drwNo: Int, completion: @escaping (Lotto?,APIError?) -> Void ) {
        // 네트워크 성공시 Lotto, 실패시 APIError
        
        //shared: 일반적인 네트워크통신(단순),커스톰x, 응답은 클로저로 받음(몇퍼센트같은거는 볼수없음), 백그라운드상태 쓸수 x
        
        // init(configuration: {} ) :
        /// {}: background: 앱사용안해도 작업할수있는것.
        /// {}: ephemeral : 정보 휘발시킬떄 사용.
        /// {}: default  유사하지만 커스텀 가능 ( ex) 셀룰러 연결 여부) , 응답클로저받고 딜리게이트쓴다.
        
        //MARK: Main Thread
        let url = URL(string:"https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(drwNo)")!
        
        /// urlSession: 네트워크하는프레임워크
        /// with: url 타입의  url주소
        /// completionHandler: 네트워크로 받아온값.
        /// dataTask(alamofire의 request와 유사)
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            //MARK: Global Thread
            // global -> main으로 바꿔줌
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
                    let result = try JSONDecoder().decode(Lotto.self, from: data)
                    print("result:",result)
                    print("result drNodate:",result.drwNoDate)
                    completion(result,nil)
                } catch {
                    print("error",error)
                    completion(nil,.invalidata)
                }
            }
        }.resume() //resume이 요청을 실제로 해달라!
        
        
    
        
        
        
        
        //dataTask가 alamofire에서 request영역과 동일.
    }
    
}

