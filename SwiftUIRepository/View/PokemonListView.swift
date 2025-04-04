//
//  PokemonListView.swift
//  SwiftUIRepository
//
//  Created by Sahil ChowKekar on 3/12/25.
//

import SwiftUI

struct PokemonListView: View {
    @StateObject var pokemonViewModel = PokemonViewModel(repository: PokemonRepository(
        networkManager: NetworkManager()))

    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemBackground).edgesIgnoringSafeArea(.all) // Background color
                
                VStack {
                    Text("Pokemon List")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                        .padding(.top, 10)
                    
                    switch pokemonViewModel.pokemonViewState {
                    case .loading:
                        loadingView()
                    case .loaded:
                        showPokemonList()
                    case .error(let error):
                        showError(error: error)
                    case .empty:
                        emptyList()
                    }
                }
            }
            .padding(.horizontal)
            .navigationBarHidden(true) // Hide default navigation bar
            .task {
                await pokemonViewModel.getPokemonList()
            }
        }
    }

    // 🔹 Loading View with Animation
    @ViewBuilder
    func loadingView() -> some View {
        VStack {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                .scaleEffect(2)
            Text("Loading Pokémon...")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.blue)
                .padding(.top, 10)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    // 🔹 Pokémon List with Card UI
    @ViewBuilder
    func showPokemonList() -> some View {
        ScrollView {
            LazyVStack(spacing: 15) {
                ForEach(pokemonViewModel.pokemonList) { pokemon in
                    NavigationLink(destination: emptyList()) {
                        PokemonListCell(pokemon: pokemon)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(Color.white)
                                    .shadow(radius: 5)
                            )
                            .padding(.horizontal)
                    }
                }
            }
            .padding(.top, 10)
        }
    }

    // 🔹 Empty List UI
    @ViewBuilder
    func emptyList() -> some View {
        VStack {
            Image(systemName: "tray.fill")
                .font(.system(size: 60))
                .foregroundColor(.gray)
            Text("No Pokémon Found")
                .font(.title2)
                .foregroundColor(.gray)
                .padding(.top, 5)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    // 🔹 Error Screen with Retry Button
    @ViewBuilder
    func showError(error: Error) -> some View {
        VStack {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 60))
                .foregroundColor(.red)
            
            Text("Oops! Something went wrong")
                .font(.title2)
                .foregroundColor(.red)
                .padding(.top, 5)
            
            Text(error.localizedDescription)
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
                .padding(.top, 5)
            
            Button(action: {
                Task {
                    await pokemonViewModel.getPokemonList()
                }
            }) {
                Text("Retry")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 120)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding(.top, 10)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    PokemonListView()
}
