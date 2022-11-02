//
//  APIService.swift
//  SesackWeek18
//
//  Created by useok on 2022/11/02.
//

import Foundation
import Alamofire

struct Login: Codable {
    let token: String
}

struct Profile: Codable {
    let user: User
}
struct User: Codable {
    let photo: String
    let email: String
    let username: String
}


class APIService {
    /// 회원가입
    func signup() {
        let api = SeSACAPI.signup(userName: "testHot", email: "testHot@naver.com", password: "testHot10")
        AF.request(api.url, method: .post, parameters: api.parameters, headers: api.headers).responseString(completionHandler: { response in
            print("signup, response:",response)
            print("signup, response.statusCode:",response.response?.statusCode ?? "signup statuscode error")
        })
    }
    ///로그인
    func login() {
        let api = SeSACAPI.login(email: "testHot@naver.com", password: "testHot10")

        AF.request(api.url,method: .post, parameters: api.parameters, headers: api.headers)
            .validate(statusCode: 200...299)
            .responseDecodable(of: Login.self) { response in // login에 디코딩해주는것
            
            switch response.result {
            case.success(let data) :  //성공시 어떻게 처리할건지 (200...299사이를 성공) , data: 성공시 가져온 데이터
                print("lgoin token:",data.token)
                UserDefaults.standard.set(data.token, forKey: "token")// 가져온 token의 정보를 userdefault에 저장
                break
            case .failure(let data) : //실패시 어떻게 처리할건지, data: 실패시 가져온 데이터
                print("lgoin fail: ",data)
            }
        }
    }
    /// 프로필보기
    func profile() {
        /// https 는 ats 필요없다.
        /// http의경우 ats 설정을해줭한다.
        /// 선택1: info.plist -> App Transport Security Settings -> Allow Arbitrary Loads -> Yes로 바꿈. 모든 통신에대한 접근을 허용)
        /// 선택2: info.plist -> App Transport Security Settings-> Exception Domains -> 사이트명(api.memolease.com)을 dictionary 이사이트에 한해서만 통신접근가능 -> NSExceptionAllowsInsecureHTTPLoads(Bool) ->Yes
        let api = SeSACAPI.profile

        AF.request(api.url,method: .get, headers: api.headers)
            .responseDecodable(of: Profile.self) { response in
                switch response.result {
                case.success(let data) :  //성공시 어떻게 처리할건지 (200...299사이를 성공) , data: 성공시 가져온 데이터
                    print("profile data: ",data)
                    
                case .failure(let data) : //실패시 어떻게 처리할건지, data: 실패시 가져온 데이터
                    print("profile fail: ",data)
                }
            }
    }
    
}
