//
//  APIManager.swift
//  NewsDemo
//
//  Created by Zülal Sarıoğlu on 7.02.2024.
//

import Foundation


class APICaller {
    static let shared = APICaller()
    
    func getData(from url : String, completion: @escaping (Result<[Article], Error>) -> Void) {
           let task = URLSession.shared.dataTask(with:URL(string: url)!, completionHandler: {data, response , error in
               guard let data = data , error == nil else  {
                   completion(.failure(error!))
                   return
               }
               do {
                   let result = try JSONDecoder().decode(Welcome.self, from: data)
                   completion(.success(result.articles))
               } catch {
                   completion(.failure(error))
               }
           })
           task.resume()
       }
    
}
