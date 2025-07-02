//
//  PokedexScreen.swift
//  PokedexList
//
//  Created by Gabriel Ferraz Fontes on 02/07/25.
//

import UI
import UIKit

fileprivate enum Layout {
    static let itemSpacing: CGFloat = 10
    static let itemSize: CGFloat = (UIScreen.main.bounds.width / 3) - (Layout.itemSpacing * 2)
    static let collectionViewSpacing: CGFloat = 15
}

final class PokedexScreen: UIView {
    let collectionDelegate: UICollectionViewDelegate
    let collectionDataSource: UICollectionViewDataSource

    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .large)
        activity.color = .darkGray

        return activity
    }()

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = Layout.itemSpacing
        layout.minimumLineSpacing = Layout.itemSpacing
        let itemSize = Layout.itemSize
        layout.itemSize = CGSize(width: itemSize, height: itemSize)

        let colletionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        colletionView.translatesAutoresizingMaskIntoConstraints = false
        colletionView.delegate = collectionDelegate
        colletionView.dataSource = collectionDataSource
        colletionView.register(PokemonViewCell.self, forCellWithReuseIdentifier: PokemonViewCell.identifier)
        colletionView.backgroundView = activityIndicator
        activityIndicator.startAnimating()

        return colletionView
    }()

    init(collectionDelegate: UICollectionViewDelegate,
         collectionDataSource: UICollectionViewDataSource) {
        self.collectionDelegate = collectionDelegate
        self.collectionDataSource = collectionDataSource
        super.init(frame: .zero)

        setupScene()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PokedexScreen: ViewConfiguration {
    func buildHierarchy() {
        addSubview(collectionView)
    }

    func addConstraints() {
        collectionView
            .make([.top, .bottom], equalTo: self)
            .make(.leading, equalTo: self, constant: Layout.collectionViewSpacing)
            .make(.trailing, equalTo: self, constant: -Layout.collectionViewSpacing)
    }

    func additionalConfigurations() {
        backgroundColor = .white
        collectionView.backgroundColor = .white
    }
}

extension PokedexScreen {
    func reloadCollection() {
        activityIndicator.stopAnimating()
        collectionView.reloadData()
    }
}
