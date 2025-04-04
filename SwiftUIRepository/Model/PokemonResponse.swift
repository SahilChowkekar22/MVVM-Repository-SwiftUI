//
//  PokemonResponse.swift
//  SwiftUIRepository
//
//  Created by Sahil ChowKekar on 3/12/25.
//

import Foundation

struct PokemonResponse: Decodable{
    let count: Int
    let next: String
    let previous: String?
    let results: [Pokemon]
}

struct Pokemon: Decodable{
    let name: String
    let url: String 
}

extension Pokemon:Identifiable{
    var id: String{
        return url + name
    }
}

//"count": 1302,
//  "next": "https://pokeapi.co/api/v2/pokemon?offset=40&limit=40",
//  "previous": null,
//  "results": [
//    {
//      "name": "bulbasaur",
//      "url": "https://pokeapi.co/api/v2/pokemon/1/"
//    },
//    {
//      "name": "ivysaur",
//      "url": "https://pokeapi.co/api/v2/pokemon/2/"
//    },
