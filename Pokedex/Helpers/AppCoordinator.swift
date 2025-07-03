//
//  AppCoordinator.swift
//  Pokedex
//
//  Created by Gabriel Ferraz Fontes on 03/07/25.
//

import UI
import UIKit
import PokedexList

final class AppCoordinator: NSObject, Coordinator {
    var parentCoordinator: Coordinator?
    var childrenCoordinators: [Coordinator] = []
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        goToPokedexList()
    }
}

private extension AppCoordinator {
    func goToPokedexList() {
        let coordinator = PokedexCoordinator(parent: self, api: Injector.make())
        childrenCoordinators.append(coordinator) // quit children when exit
        coordinator.start()
    }
}
