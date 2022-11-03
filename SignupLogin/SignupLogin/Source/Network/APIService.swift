//
//  APIService.swift
//  SesackWeek18
//
//  Created by useok on 2022/11/02.
//


import Alamofire
import UIKit




final class APIService {
    //MARK: - 싱글턴 변수
    
    typealias completionHandler = ((Bool) -> ())
    typealias ProfileInfo = ((Profile?) -> ())
    
    init() {}
    
    
    /// 회원가입
    func signup(username: String, email: String, password: String,completionHandler: @escaping completionHandler ) {
        let api = API.signup(userName: username, email: email, password: password)
        
        AF.request(api.url, method: .post, parameters: api.parameters, headers: api.headers)
            .validate(statusCode: 200...299)
            .responseString(completionHandler: { response in
                print("signup, response:",response)
                print("signup, response.statusCode:",response.response?.statusCode ?? "signup statuscode error")
                switch response.result {
                case .success(let data):
                    completionHandler(true)
                    print(data)
                case .failure(let error):
                    completionHandler(false)
                    print(error)
                }
            })
    }
    
    ///로그인
    func login(email: String, password: String, completionHandler: @escaping completionHandler  ) {
        let api = API.login(email: email, password: password)
        
        AF.request(api.url,method: .post, parameters: api.parameters, headers: api.headers)
            .validate(statusCode: 200...299)
            .responseDecodable(of: Login.self) { response in
                
                switch response.result {
                    
                case.success(let data) :
                    print("lgoin token:",data.token)
                    UserDefaults.standard.set(data.token, forKey: "token")
                    completionHandler(true)
                case .failure(let error) :
                    completionHandler(false)
                    print("lgoin fail: ",error)
                }
            }
    }
    /// 프로필보기
    func profile(completionHandler: @escaping ProfileInfo) {
        let api = API.profile
        AF.request(api.url,method: .get, headers: api.headers)
            .responseDecodable(of: Profile.self) { response in
                switch response.result {
                case.success(let data) :
                    completionHandler(data)
                case .failure(let error) :
                    print("profile fail: \(error)")
                }
            }
    }
}

