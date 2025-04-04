//
//  PokemonRepositoryTests.swift
//  SwiftUIRepositoryTests
//
//  Created by Sahil ChowKekar on 3/13/25.
//

import XCTest
@testable import SwiftUIRepository

final class PokemonRepositoryTests: XCTestCase {

    var repository: PokemonRepository!
    var fakeManager: FakeNetworkManager!
    
    override func setUpWithError() throws {
        //Given
        fakeManager = FakeNetworkManager()
        repository = PokemonRepository(networkManager: fakeManager)
    }

    override func tearDownWithError() throws {
        fakeManager = nil
        repository = nil
         
    }

    func testGetPokemons_ExpextingCorrectData() async throws {
        
        fakeManager.testPath = "ValidPokemon"
        let pokemonResponse = try await repository.getPokemons()
        
        
        XCTAssertNotNil(pokemonResponse)
        XCTAssertEqual(pokemonResponse.results.count, 40)
        let pokemon = pokemonResponse.results.first!
        XCTAssertEqual (pokemon.name, "bulbasaur")
        XCTAssertEqual (pokemon.url, "https://pokeapi.co/api/v2/pokemon/1/")
        XCTAssertEqual(pokemonResponse.count, 1302)
        XCTAssertEqual(pokemonResponse.next, "https://pokeapi.co/api/v2/pokemon?offset=40&limit=40")
        XCTAssertNil (pokemonResponse.previous)
        
        
    }
    
    func testGetPokemonsData_WhenWeGetNoData() async throws {
        //when
        fakeManager.testPath = "NoData.json"
        
        do{
            let pokemonResponse = try await repository.getPokemons()
            XCTAssertEqual (pokemonResponse.results.count,0)
        }catch{
            XCTAssertNotNil (error)
        }
    }

    func testGetPokemonsData_WhenHaveInValidData() async throws {
        //when
        fakeManager.testPath = "InValidPokemon.json"
        
        do{
            let pokemonResponse = try await repository.getPokemons()
            XCTAssertEqual (pokemonResponse.results.count,0)
        }catch{
            XCTAssertNotNil(error)
//            XCTAssertTrue (error is DecodingError)
        }
    }

    func testPerformData() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
