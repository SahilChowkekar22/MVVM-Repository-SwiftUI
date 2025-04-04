//
//  PokemonRepositoryStub.swift
//  SwiftUIRepositoryTests
//
//  Created by Sahil ChowKekar on 3/13/25.
//

import Foundation
@testable import SwiftUIRepository

class PokemonRepositoryStub:PokemonRepositoryAction{
    private var error:NetworkError?
    private var pokemonResponse: PokemonResponse?
    
    func getPokemons() async throws -> SwiftUIRepository.PokemonResponse {
        if error != nil{
            throw error!
        }
        return pokemonResponse!
    }
    
    func setError(error: NetworkError){
        self.error = error
    }
    func setResponse(pokemonResponse:PokemonResponse){
        self.pokemonResponse = pokemonResponse
    }
    
}
