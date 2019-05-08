//
//  NetworkManager.swift
//  SearchingTest
//
//  Created by Anton Romanov on 07/05/2019.
//  Copyright © 2019 Anton Romanov. All rights reserved.
//

import Foundation

class NetworkManager {
    
    // MARK: - Class methods
    class func request<T: Codable>(forSource source: Source, with searchReq: String, completion: @escaping (Result<T, Error>) -> ()) {

        let url = URL(string: (source.baseURL + searchReq.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!))!
        
        let urlRequest = URLRequest(url: url)
        
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            
            guard response != nil else {
                return
            }
            guard let data = data else {
                return
            }
            
            do {
                let responseObject = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(responseObject))
                }
                
            } catch (let decodingError) {
                print("\n decoding error = \(decodingError)\n")
                completion(.failure(decodingError))
                return
            }
            
        }
        dataTask.resume()
    }
}
