//
//  Injector.swift
//  Pokedex
//
//  Created by Gabriel Ferraz Fontes on 02/07/25.
//

import CoreNetworkProtocols

import CoreNetwork

enum Injector {
    static func make() -> APIRepository {
        API()
    }
}
