//
//  PokedexCoordinator.swift
//  PokedexList
//
//  Created by Gabriel Ferraz Fontes on 03/07/25.
//

import UI
import UIKit
import CoreNetworkProtocols

public final class PokedexCoordinator: NSObject, Coordinator {
    public weak var parentCoordinator: Coordinator?
    public var childrenCoordinators: [Coordinator] = []
    public var navigationController: UINavigationController

    private var api: APIRepository

    public init(parent: Coordinator, api: APIRepository) {
        self.navigationController = parent.navigationController
        self.parentCoordinator = parent
        self.api = api
    }

    public func start() {
        let viewController = PokedexFactory.make(coordinator: self, api: api)
        navigationController.pushViewController(viewController, animated: true)
    }
}
