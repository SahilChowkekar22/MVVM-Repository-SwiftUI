//
//  PokemonListRequest.swift
//  SwiftUIRepository
//
//  Created by Sahil ChowKekar on 3/13/25.
//

import Foundation

struct PokemonListRequest:Requestable{
    var parameters: [String : String]
    
    var path: String
    
    var type: String
    
}
