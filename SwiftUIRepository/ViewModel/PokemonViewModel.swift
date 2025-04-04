//
//  PokemonViewModel.swift
//  SwiftUIRepository
//
//  Created by Sahil ChowKekar on 3/12/25.
//

import Foundation

enum PokemonViewState: Error, Equatable {
    case loading
    case loaded
    case error(Error)
    case empty

    static func == (lhs: PokemonViewState, rhs: PokemonViewState) -> Bool {
        switch (lhs, rhs) {
        case (.error(let leftError), .error(let righError)):
            return leftError.localizedDescription
                == righError.localizedDescription
        default:
            return true
        }
    }
}

final class PokemonViewModel: ObservableObject {
    @Published var pokemonList = [Pokemon]()
    @Published var pokemonViewState: PokemonViewState = .loading

    private var repository: PokemonRepositoryAction

    init(repository: PokemonRepositoryAction) {
        self.repository = repository
    }

    @MainActor
    func getPokemonList() async {
        pokemonViewState = .loading

        do {

            pokemonList = try await self.repository.getPokemons().results
            pokemonViewState = .loaded
        } catch {
            pokemonViewState = .error(error)
            print(error.localizedDescription)
        }

    }
}
