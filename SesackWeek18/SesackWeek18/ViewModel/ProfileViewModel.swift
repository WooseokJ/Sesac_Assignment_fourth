//
//  ViewModel.swift
//  SesackWeek18
//
//  Created by useok on 2022/11/03.
//

import Foundation
import RxSwift
class ProfileViewModel {
    
    let profile = PublishSubject<Profile>()
    
    func getProfile() {
        let api = SeSACAPI.profile
                
        Network.shared.requestSeSac(type: Profile.self, url: api.url, headers: api.headers) { [weak self] response in //response는 ResultType
            switch response {
            case .success(let success): // success = Profile 이 들어옴
                self?.profile.onNext(success)
            case .failure(let failure):
                self?.profile.onError(failure)
            }
        }
        

        
    }
}
