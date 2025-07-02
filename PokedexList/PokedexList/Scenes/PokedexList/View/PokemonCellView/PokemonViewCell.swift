//
//  PokemonViewCell.swift
//  PokedexList
//
//  Created by Gabriel Ferraz Fontes on 02/07/25.
//

import UIKit
import UI

protocol PokemonViewCellDisplaying {
    func setupCell(with pokemon: PokemonCellModel)
}

final class PokemonViewCell: UICollectionViewCell {
    static let identifier = "PokemonCell"

    lazy var view = PokemonCellScreen()

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        backgroundView = view
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PokemonViewCell: PokemonViewCellDisplaying {
    func setupCell(with pokemon: PokemonCellModel) {
        view.setupCell(with: pokemon)
    }
}
