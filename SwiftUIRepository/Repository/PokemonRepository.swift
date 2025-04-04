//
//  PokemonRepository.swift
//  SwiftUIRepository
//
//  Created by Sahil ChowKekar on 3/12/25.
//

import Foundation

protocol PokemonRepositoryAction{
    func getPokemons() async throws -> PokemonResponse
}

class PokemonRepository{
    
    private var networkManager: NetworkManagerActions
    
    init(networkManager: NetworkManagerActions) {
        self.networkManager = networkManager
         
        
    }
     
}

extension PokemonRepository:PokemonRepositoryAction{
    func getPokemons() async throws -> PokemonResponse {
        
//        guard let url = URL(string: APIEndpoint.baseURL+APIEndpoint.pokemonEndPoints) else{
//            throw NetworkError.invalidURL
//            
//        }
        
        do{
         
            let parms = ["offset": "40",
                         "limit": "40"]
            
            
            let pokemonListRequest = PokemonListRequest(parameters: parms, path: APIEndpoint.pokemonEndPoints, type: "GET")
            let pokemonResponse = try await self.networkManager.fetchDataFromURL(urlRequest: pokemonListRequest, modelType: PokemonResponse.self)
            print(pokemonResponse)
            return pokemonResponse
        }
        catch{
            throw error
        }
    }
    
    
}
