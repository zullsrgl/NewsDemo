//
//  APIManager.swift
//  NewsDemo
//
//  Created by Zülal Sarıoğlu on 7.02.2024.
//

import Foundation
import Alamofire

class APICaller {
    static let shared = APICaller()
    
    func getData(from url : String, completion: @escaping (Result<[Article], Error>) -> Void) {
        AF.request(url).responseData{response in
            switch response.result {
            case.success(let data) :
                do {
                    let result = try JSONDecoder().decode(Welcome.self, from: data)
                    completion(.success(result.articles))
                }catch{
                    completion(.failure(error))
                }
            case.failure(_):
                print("error")
            }
        }
    }
}
