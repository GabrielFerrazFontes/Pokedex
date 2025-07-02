//
//  PokemonListResponse.swift
//  PokedexList
//
//  Created by Gabriel Ferraz Fontes on 02/07/25.
//

struct PokemonListResponse: Decodable {
    let next: String?
    let previous: String?
    let results: [PokemonResponse]
}

struct PokemonResponse: Decodable {
    let url: String
}
