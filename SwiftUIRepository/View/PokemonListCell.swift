//
//  PokemonListCell.swift
//  SwiftUIRepository
//
//  Created by Sahil ChowKekar on 3/12/25.
//

import SwiftUI

struct PokemonListCell: View {
    let pokemon:Pokemon
    var body: some View {
        VStack{
            Text(pokemon.name)
                .font(.title)
            
            Text(pokemon.url)
                .font(.caption)
        }
    }
}

#Preview {
    PokemonListCell(pokemon: Pokemon(name: "nidorina", url:" https://pokeapi.co/api/v2/pokemon/30/"))
}
