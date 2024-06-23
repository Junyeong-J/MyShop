//
//  NaverShopManager.swift
//  MyShopping
//
//  Created by 전준영 on 6/23/24.
//

import Foundation
import Alamofire

class NaverShopManager {
    
    static let shared = NaverShopManager()
    private init() {}
    
    func getNaverShop(query: String, sort: String, start: Int, completion: @escaping (Result<Shop, NetworkError>) -> Void) {
        let url = APIURL.naverShopURL
        let params = [
            "query" : query,
            "display": 30,
            "start": start,
            "sort": sort
        ] as [String : Any]
        
        let headers: HTTPHeaders = ["X-Naver-Client-Id": APIKey.naverClient_id,
                                    "X-Naver-Client-Secret": APIKey.naverClient_secret]
        AF.request(url, parameters: params, headers: headers).responseDecodable(of: Shop.self) { response in
            switch response.result{
            case .success(let value):
                completion(.success(value))
            case .failure(_):
                completion(.failure(.networkError))
            }
        }
    }
    
    
    
}
