//
//  APIService.swift
//  SesackWeek18
//
//  Created by useok on 2022/11/02.
//


import Alamofire
import UIKit



final class APIService {
    typealias completionHandler = ((Bool) -> ())
    typealias ProfileInfo = ((Profile?) -> ())
    
    init() {}
    /// 회원가입
    func signup(username: String, email: String, password: String,completionHandler: @escaping completionHandler ) {
        let api = API.signup(userName: username, email: email, password: password)
        AF.request(api.url, method: .post, parameters: api.parameters, headers: api.headers).responseString(completionHandler: { response in
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
    func login(email: String, password: String ) {
        let api = API.login(email: email, password: password)

        AF.request(api.url,method: .post, parameters: api.parameters, headers: api.headers)
            .validate(statusCode: 200...299)
            .responseDecodable(of: Login.self) { response in // login에 디코딩해주는것
            
            switch response.result {
                
            case.success(let data) :  //성공시 어떻게 처리할건지 (200...299사이를 성공) , data: 성공시 가져온 데이터
                print("lgoin token:",data.token)
                UserDefaults.standard.set(data.token, forKey: "token")// 가져온 token의 정보를 userdefault에 저장
//                completionHandler(true)
                
            case .failure(let error) : //실패시 어떻게 처리할건지, data: 실패시 가져온 데이터
//                completionHandler(false)
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
                case.success(let data) :  //성공시 어떻게 처리할건지 (200...299사이를 성공) , data: 성공시 가져온 데이터
                    print("profile data: ",data.user.email)
                    print("profile data: ",data.user.username)
                    print("profile data: ",data.user.photo)
                    
                    
                case .failure(let data) : //실패시 어떻게 처리할건지, data: 실패시 가져온 데이터
                    print("profile fail: ",data)
                }
            }
    }
    

    
    
    
}
