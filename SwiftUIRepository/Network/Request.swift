//
//  Request.swift
//  SwiftUIRepository
//
//  Created by Sahil ChowKekar on 3/13/25.
//

import Foundation

protocol Requestable {
    var baseURL: String { get }
    var path: String { get }
    var headers: [String: String] { get }
    var parameters: [String: String] { get }
    var type: String { get }
    func createURLRequest() -> URLRequest?
}

extension Requestable{
    var baseURL: String {
        return APIEndpoint.baseURL
    }
    
    var headers: [String: String] {
        return [:]
    }
    
    
    
    func createURLRequest()  -> URLRequest? {
        guard baseURL.count > 0, path.count > 0 else {
            return nil
        }
        
        var urlComponents = URLComponents(string: baseURL + path)
        print(urlComponents)
        var queryParameters:[URLQueryItem] = []
        
        for (key,value) in parameters {
            queryParameters.append(URLQueryItem(name: key, value: value))
        }
        
        urlComponents?.queryItems = queryParameters
        
        guard let url = urlComponents?.url else {return nil}
        
        let request = URLRequest(url: url)
//        print(request)
        return request
        
        
    }
}
