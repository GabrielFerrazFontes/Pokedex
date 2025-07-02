//
//  PokemonCellModel.swift
//  PokedexList
//
//  Created by Gabriel Ferraz Fontes on 02/07/25.
//

import Foundation

struct PokemonCellModel {
    let name: String
    let number: String
    let image: Data
}

extension PokemonCellModel: Equatable { }
