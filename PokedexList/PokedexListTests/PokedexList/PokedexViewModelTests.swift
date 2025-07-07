//
//  PokedexViewModelTests.swift
//  PokedexListTests
//
//  Created by Gabriel Ferraz Fontes on 07/07/25.
//

import XCTest
import CoreNetworkProtocols
@testable import PokedexList

final class GetPokemonListStub: GetPokemonListUseCase {
    private(set) var pokemons: [PokemonEntity] = []
    private(set) var error: APIError?

    private(set) var callGetPokemons = 0

    func setPokemons(_ pokemons: [PokemonEntity]) {
        self.pokemons = pokemons
    }

    func setError(_ error: APIError) {
        self.error = error
    }

    func getPokemonList(completion: @escaping (Result<[PokemonEntity], APIError>) -> Void) {
        callGetPokemons += 1

        if let error = self.error {
            completion(.failure(error))
        } else {
            completion(.success(pokemons))
        }
    }
}

final class PokedexViewModelTests: XCTestCase {
    private let useCase = GetPokemonListStub()
    private lazy var sut = PokedexViewModel(getPokemonUseCase: useCase)

    func testGetPokemons_WhenGetPokemons_ShouldCallDidFinish() {
        useCase.setPokemons(PokemonEntityDummy.list())

        sut.getPokemons { [weak self] didFinish in
            if didFinish {
                XCTAssertEqual(self?.useCase.callGetPokemons, 1)
                XCTAssertEqual(self?.useCase.pokemons, PokemonEntityDummy.list())
                XCTAssertNil(self?.useCase.error)
            } else {
                XCTFail()
            }
        }
    }

    func testGetPokemons_WhenGetError_ShouldCallDidFinish() {
        useCase.setError(APIError.generic)

        sut.getPokemons { [weak self] didFinish in
            if didFinish {
                XCTAssertEqual(self?.useCase.callGetPokemons, 1)
                XCTAssertEqual(self?.useCase.error, APIError.generic)
                XCTAssertEqual(self?.useCase.pokemons, [])
            } else {
                XCTFail()
            }
        }
    }

    func testNumberOfItemsInSection_WhenHasPokemons_ShouldReturnCountOfPokemons() {
        useCase.setPokemons(PokemonEntityDummy.list())

        sut.getPokemons { [weak self] _ in
            let itemCount = self?.sut.numberOfItemsInSection()
            XCTAssertEqual(itemCount, PokemonEntityDummy.list().count)
        }
    }

    func testNumberOfItemsInSection_WhenHasNoPokemons_ShouldReturnZero() {
        useCase.setError(.generic)

        sut.getPokemons { [weak self] _ in
            let itemCount = self?.sut.numberOfItemsInSection()
            XCTAssertEqual(itemCount, 0)
        }
    }

    func testCellForItemAt_WhenHasPokemons_ShouldReturnConfiguredCell() {
        useCase.setPokemons(PokemonEntityDummy.list())

        sut.getPokemons { [weak self] _ in
            let result = self?.sut.cellForItemAt(0)
            XCTAssertEqual(result, self?.sut.pokemons[0])
        }
    }

    func testCellForItemAt_WhenHasNoPokemons_ShouldReturnConfiguredCell() {
        useCase.setError(.generic)

        sut.getPokemons { [weak self] _ in
            let result = self?.sut.cellForItemAt(9999)
            XCTAssertEqual(result, PokemonCellModel.defaultCell)
        }
    }
}
