//
//  PokedexFactory.swift
//  PokedexList
//
//  Created by Gabriel Ferraz Fontes on 02/07/25.
//

import CoreNetworkProtocols
import UI
import UIKit

enum PokedexFactory {
    static func make(coordinator: Coordinator, api: APIRepository) -> UIViewController {
        let coordinator = PokedexCoordinator(parent: coordinator, api: api)
        let repository: Repository = APIPokedex(api: api)
        let useCase: GetPokemonListUseCase = GetPokemonList(repository: repository)
        let viewModel: PokedexViewModeling = PokedexViewModel(getPokemonUseCase: useCase)
        let viewController = PokedexViewController(viewModel: viewModel)

        return viewController
    }
}

