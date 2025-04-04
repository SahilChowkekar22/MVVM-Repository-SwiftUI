//
//  NetworkManagerTests.swift
//  SwiftUIRepositoryTests
//
//  Created by Sahil ChowKekar on 3/14/25.
//

import XCTest

@testable import SwiftUIRepository

final class NetworkManagerTests: XCTestCase {
    var networkManager: NetworkManager!
    var mocksession: MockSession!

    override func setUpWithError() throws {
        mocksession = MockSession()
        networkManager = NetworkManager(urlSession: mocksession)
    }

    override func tearDownWithError() throws {

    }

    func testFetchDataFromURL_WhenExpectingCorrectResult() async throws {
        //when
        let expectation = expectation(
            description:
                "fetching data from Network Manager and expectation correct result"
        )

        let dummyData = """
            {
              "count": 1302,
              "next": "https://pokeapi.co/api/v2/pokemon?offset=40&limit=40",
              "previous": null,
              "results": [
                {
                  "name": "bulbasaur",
                  "url": "https://pokeapi.co/api/v2/pokemon/1/"
                },
                {
                  "name": "ivysaur",
                  "url": "https://pokeapi.co/api/v2/pokemon/2/"
                }
              ]
            }
            """.data(using: .utf8)
        mocksession.setData(data: dummyData!)

        let urlResponse = HTTPURLResponse(
            url: URL(string: "testURL")!, statusCode: 200, httpVersion: nil,
            headerFields: nil)
        mocksession.setURLResponse(urlResponse: urlResponse!)

        var pokemonResponse: PokemonResponse?
        Task {
            let testRequest = PokemonListRequest(
                parameters: [:], path: APIEndpoint.pokemonEndPoints, type: "GET"
            )
            pokemonResponse = try await networkManager.fetchDataFromURL(
                urlRequest: testRequest, modelType: PokemonResponse.self)
            expectation.fulfill()
        }

        await fulfillment(of: [expectation], timeout: 1)
        //then
        XCTAssertNotNil(pokemonResponse)
        XCTAssertNotNil(pokemonResponse)
        XCTAssertEqual(pokemonResponse?.results.count, 2)
        let pokemon = pokemonResponse?.results.first!
        XCTAssertEqual(pokemon?.name, "bulbasaur")
        XCTAssertEqual(pokemon?.url, "https://pokeapi.co/api/v2/pokemon/1/")
        XCTAssertEqual(pokemonResponse?.count, 1302)
        XCTAssertEqual(
            pokemonResponse?.next,
            "https://pokeapi.co/api/v2/pokemon?offset=40&limit=40")
        XCTAssertNil(pokemonResponse?.previous)
        //        XCTAssertEqual(viewModel.pokemonList.count, 1)
        //        let pokemon = viewModel.pokemonList.first!
        //        XCTAssertEqual(pokemon.name, "bulbasaur")
        //        XCTAssertEqual(pokemon.url, "https://pokeapi.co/api/v2/pokemon/1/")
    }

    func testFetchDataFromURL_WhenExpecting404Error() async throws {
        //when
        let expectation = expectation(
            description:
                "fetching data from Network Manager and expectation 404 Error"
        )

        let dummyData = """
            {
              "count": 1302,
              "next": "https://pokeapi.co/api/v2/pokemon?offset=40&limit=40",
              "previous": null,
              "results": [
                {
                  "name": "bulbasaur",
                  "url": "https://pokeapi.co/api/v2/pokemon/1/"
                },
                {
                  "name": "ivysaur",
                  "url": "https://pokeapi.co/api/v2/pokemon/2/"
                }
              ]
            }
            """.data(using: .utf8)
        mocksession.setData(data: dummyData!)

        let urlResponse = HTTPURLResponse(
            url: URL(string: "testURL")!, statusCode: 404, httpVersion: nil,
            headerFields: nil)
        mocksession.setURLResponse(urlResponse: urlResponse!)

        var pokemonResponse: PokemonResponse?
        var caughtError: Error?

        Task {
            let testRequest = PokemonListRequest(
                parameters: [:], path: APIEndpoint.pokemonEndPoints, type: "GET"
            )
            do {
                pokemonResponse = try await networkManager.fetchDataFromURL(
                    urlRequest: testRequest, modelType: PokemonResponse.self)
                XCTAssertNil(pokemonResponse)
            } catch {
                caughtError = error
            }
            expectation.fulfill()
        }

        await fulfillment(of: [expectation], timeout: 1)
        //then

        XCTAssertNotNil(caughtError)
       

    }
    
    func testGetDataFromWebService_WhenRequestIsInvalidAndExpectingInvalidRequestError() async throws {
        //when
        let expectation = expectation(
            description:
                "fetching data from Network Manager and expectation Invalid Request Error"
        )

        let dummyData = """
            {
              "count": 1302,
              "next": "https://pokeapi.co/api/v2/pokemon?offset=40&limit=40",
              "previous": null,
              "results": [
                {
                  "name": "bulbasaur",
                  "url": "https://pokeapi.co/api/v2/pokemon/1/"
                },
                {
                  "name": "ivysaur",
                  "url": "https://pokeapi.co/api/v2/pokemon/2/"
                }
              ]
            }
            """.data(using: .utf8)
        mocksession.setData(data: dummyData!)

        let urlResponse = HTTPURLResponse(
            url: URL(string: "testURL")!, statusCode: 200, httpVersion: nil,
            headerFields: nil)
        mocksession.setURLResponse(urlResponse: urlResponse!)

        var pokemonResponse: PokemonResponse?
        var caughtError: Error?

        Task {
            let testRequest = PokemonListRequest(
                parameters: [:], path: "", type: "GET"
            )
            do {
                pokemonResponse = try await networkManager.fetchDataFromURL(
                    urlRequest: testRequest, modelType: PokemonResponse.self)
                XCTAssertNil(pokemonResponse)
            } catch {
                caughtError = error
            }
            expectation.fulfill()
        }

        await fulfillment(of: [expectation], timeout: 1)
        //then

        XCTAssertNotNil(caughtError)
       

    }
    
    func testGetDataFromWebService_WhenRequestRequestIsCorrectButExpectingParsingError() async throws {
        //when
        let expectation = expectation(
            description:
                "fetching data from Network Manager and expectation Invalid Parsing Error"
        )

        let dummyData = """
            {
              "asd": 1302,
              "next": "https://pokeapi.co/api/v2/pokemon?offset=40&limit=40",
              "dsas": null,
              "results": [
                {
                  "name": "bulbasaur",
                  "url": "https://pokeapi.co/api/v2/pokemon/1/"
                },
                {
                  "name": "ivysaur",
                  "url": "https://pokeapi.co/api/v2/pokemon/2/"
                }
              ]
            }
            """.data(using: .utf8)
        mocksession.setData(data: dummyData!)

        let urlResponse = HTTPURLResponse(
            url: URL(string: "testURL")!, statusCode: 200, httpVersion: nil,
            headerFields: nil)
        mocksession.setURLResponse(urlResponse: urlResponse!)

        var pokemonResponse: PokemonResponse?
        var caughtError: Error?

        Task {
            let testRequest = PokemonListRequest(
                parameters: [:], path: APIEndpoint.pokemonEndPoints  , type: "GET"
            )
            do {
                pokemonResponse = try await networkManager.fetchDataFromURL(
                    urlRequest: testRequest, modelType: PokemonResponse.self)
                XCTAssertNil(pokemonResponse)
            } catch {
                caughtError = error
            }
            expectation.fulfill()
        }

        await fulfillment(of: [expectation], timeout: 1)
        //then

        XCTAssertNotNil(caughtError)
       

    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
