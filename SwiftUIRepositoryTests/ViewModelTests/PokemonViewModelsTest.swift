//
//  PokemonViewModelsTest.swift
//  SwiftUIRepositoryTests
//
//  Created by Sahil ChowKekar on 3/13/25.
//

import XCTest

@testable import SwiftUIRepository

final class PokemonViewModelsTest: XCTestCase {
    var viewModel: PokemonViewModel!
    var repository: PokemonRepositoryStub!

    override func setUpWithError() throws {
        repository = PokemonRepositoryStub()
        viewModel = PokemonViewModel(repository: repository)
    }

    override func tearDownWithError() throws {
        repository = nil
        viewModel = nil
    }

    func testGetPokemonList_WhenWeExpectCorrectBehaviour() async throws {

        //when
        let expectation = expectation(description: "fetching Pokemon data and expectation correct result")
        repository.setResponse(
            pokemonResponse: PokemonResponse(
                count: 100, next: "someURl", previous: nil,
                results: [
                    Pokemon(
                        name: "bulbasaur",
                        url: "https://pokeapi.co/api/v2/pokemon/1/")
                ]))
        
        Task{
            await viewModel.getPokemonList()
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 1)
        //then
        XCTAssertEqual(viewModel.pokemonList.count, 1)
        let pokemon = viewModel.pokemonList.first!
        XCTAssertEqual(pokemon.name, "bulbasaur")
        XCTAssertEqual(pokemon.url, "https://pokeapi.co/api/v2/pokemon/1/")
    }
    
    func testGetPokemonList_WhenWeExpectNoData() async throws {

        //when
        let expectation = expectation(description: "fetching Pokemon data and expectation No result")
        repository.setError(error: NetworkError.noDataError)
        
        Task{
            await viewModel.getPokemonList()
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 1)
        
        //then
        XCTAssertEqual(viewModel.pokemonList.count, 0)
        XCTAssertEqual(viewModel.pokemonViewState, PokemonViewState.error( NetworkError.noDataError))
        
    }
    
    func testGetPokemonList_WhenWeExpectParsingError() async throws {

        //when
        let expectation = expectation(description: "fetching Pokemon data and expectation Parsing Error")
        repository.setError(error: NetworkError.parsingError)
        
        Task{
            await viewModel.getPokemonList()
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 1)
        
        //then
        XCTAssertEqual(viewModel.pokemonList.count, 0)
        XCTAssertEqual(viewModel.pokemonViewState, PokemonViewState.error( NetworkError.parsingError))
        
    }
    
    func testGetPokemonList_WhenWeExpectInValidURL() async throws {

        //when
        let expectation = expectation(description: "fetching Pokemon data and expectation Invalid URL")
        repository.setError(error: NetworkError.invalidURL)
        
        Task{
            await viewModel.getPokemonList()
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 1)
        
        //then
        XCTAssertEqual(viewModel.pokemonList.count, 0)
        XCTAssertEqual(viewModel.pokemonViewState, PokemonViewState.error( NetworkError.invalidURL))
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
