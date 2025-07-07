//
//  File.swift
//  PokedexListTests
//
//  Created by Gabriel Ferraz Fontes on 07/07/25.
//

@testable import PokedexList

enum PokemonEntityDummy {
    static let statsDummy = [Stats(baseStat: 5, name: "hp")]

    static func pokemon() -> PokemonEntity {
        return PokemonEntity(height: 1,
                             id: 1,
                             name: "pikachu",
                             sprite: "",
                             stats: statsDummy,
                             types: ["eletric"],
                             weight: 1)
    }

    static func list() -> [PokemonEntity] {
        [pokemon(), pokemon()]
    }
}
