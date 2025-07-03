//
//  Coordinator.swift
//  UI
//
//  Created by Gabriel Ferraz Fontes on 03/07/25.
//

import UIKit

public protocol Coordinator: NSObject {
    var parentCoordinator: Coordinator? { get set }
    var childrenCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}
