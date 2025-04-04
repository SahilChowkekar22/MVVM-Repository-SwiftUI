//
//  URLResponseExtension.swift
//  SwiftUIRepository
//
//  Created by Sahil ChowKekar on 3/12/25.
//
import Foundation

extension URLResponse {
    func isValidResponse() -> Bool {
        guard let response = self as? HTTPURLResponse else {
            return false
        }

        switch response.statusCode {
        case 200...299:
            return true

        default:
            return false
        }
    }
}
