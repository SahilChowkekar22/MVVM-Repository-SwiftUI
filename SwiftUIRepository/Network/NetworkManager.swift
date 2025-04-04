//
//  APIServiceManager.swift
//  DigiHunt
//
//  Created by Sahil ChowKekar on 3/3/25.
//

import Foundation

protocol NetworkManagerActions {
    func fetchDataFromURL<T: Decodable>(urlRequest: Requestable, modelType: T.Type)
        async throws
        -> T
}

class NetworkManager {
    let urlSession: NetworkSessionable

    init(urlSession: NetworkSessionable = URLSession.shared) {
        self.urlSession = urlSession
    }

}

extension NetworkManager: NetworkManagerActions {
    func fetchDataFromURL<T: Decodable>(urlRequest: Requestable, modelType: T.Type)
        async throws -> T where T: Decodable
    {
        do {
            guard let request = urlRequest.createURLRequest() else {
                throw NetworkError.invalidURL
            }
            
            
            let (data, response) = try await urlSession.data(for: request, delegate: nil)
            if response.isValidResponse() {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                return decodedData
            } else {
                throw NetworkError.invalidResponse((response as? HTTPURLResponse)? .statusCode ?? 0)
            } 

        } catch {
            throw error
        }

    }

}

 
