//
//  NetworkError.swift
//  SwiftUIRepository
//
//  Created by Sahil ChowKekar on 3/12/25.
//


import Foundation

enum NetworkError: Error {
    case invalidResponse(Int)
    case invalidURL
    case parsingError
    case noDataError
    case responsError(Int)
}
