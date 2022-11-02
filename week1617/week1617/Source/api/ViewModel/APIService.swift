
import Foundation
import Alamofire


class APIService {
    static func searchPhoto(query: String, completion: @escaping (SearchPhoto?, Int?, Error?) -> Void) {
        let url = "\(APIKey.searchURL)\(query)"
        let header: HTTPHeaders = ["Authorization": APIKey.authorization]

        AF.request(url,method: .get,headers: header).responseDecodable(of: SearchPhoto.self) { response in
            let statusCode = response.response?.statusCode //상태코드 조건문처리시 사용
            switch response.result {
                case .success(let value):
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
