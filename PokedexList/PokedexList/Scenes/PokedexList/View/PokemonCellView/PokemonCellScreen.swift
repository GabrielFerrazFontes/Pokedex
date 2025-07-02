//
//  PokemonCellScreen.swift
//  PokedexList
//
//  Created by Gabriel Ferraz Fontes on 02/07/25.
//

import UIKit
import UI

fileprivate enum Layout {
    static let layerCornerRadius: CGFloat = 5
    static let labelNameSize: CGFloat = 16
    static let labelNameHeight: CGFloat = 16
    static let labelNumberSize: CGFloat = 14
    static let labelNumberHeight: CGFloat = 20
}

final class PokemonCellScreen: UIView {
    let defaultImage = "pokemonDefault"
    let defaultName = "Pikachu"
    let defaultNumber = "#25"

    let fontName = "Arial"

    private lazy var backgroundSubview: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = Layout.layerCornerRadius

        return view
    }()

    private lazy var pokemonImage: UIImageView = {
        let imageDefault = UIImage(named: defaultImage)
        let imageView = UIImageView(image: imageDefault)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.setContentHuggingPriority(.required, for: .horizontal)

        return imageView
    }()

    private lazy var pokemonNameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: fontName, size: Layout.labelNameSize)
        label.textColor = .black
        label.textAlignment = .center
        label.text = defaultName

        return label
    }()

    private lazy var pokemonNumberLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: fontName, size: Layout.labelNumberSize)
        label.textColor = .black
        label.textAlignment = .center
        label.text = defaultNumber

        return label
    }()

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupScene()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PokemonCellScreen: ViewConfiguration {
    func buildHierarchy() {
        addSubview(backgroundSubview)
        backgroundSubview.addSubview(pokemonImage)
        backgroundSubview.addSubview(pokemonNameLabel)
        backgroundSubview.addSubview(pokemonNumberLabel)
    }

    func addConstraints() {
        backgroundSubview
            .make([.top, .bottom, .leading, .trailing], equalTo: self)

        pokemonNumberLabel
            .make(.height, equalTo: Layout.labelNumberHeight)
            .make([.leading, .bottom, .trailing], equalTo: backgroundSubview)

        pokemonNameLabel
            .make([.trailing, .leading], equalTo: backgroundSubview)
            .make([.bottom], equalTo: pokemonNumberLabel, attribute: .top)
            .make(.height, equalTo: Layout.labelNameHeight)

        pokemonImage
            .make([.top, .leading, .trailing], equalTo: backgroundSubview)
            .make(.bottom, equalTo: pokemonNameLabel, attribute: .top)
    }
}

extension PokemonCellScreen {
    func setupCell(with pokemon: PokemonCellModel) {
        pokemonImage.image = UIImage(data: pokemon.image)
        pokemonNameLabel.text = pokemon.name
        pokemonNumberLabel.text = pokemon.number
    }
}
