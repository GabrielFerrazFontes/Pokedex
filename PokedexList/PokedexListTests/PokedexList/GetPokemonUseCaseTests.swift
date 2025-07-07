//
//  GetPokemonUseCaseTests.swift
//  PokedexListTests
//
//  Created by Gabriel Ferraz Fontes on 07/07/25.
//

import XCTest
import CoreNetworkProtocols
@testable import PokedexList

final class RepositoryStub: Repository {
    private(set) var pokemons: [PokemonEntity] = []
    private(set) var error: APIError?

    private(set) var callFetchPokemons = 0

    func setPokemons(_ pokemons: [PokemonEntity]) {
        self.pokemons = pokemons
    }

    func setError(_ error: APIError) {
        self.error = error
    }

    func fetchPokemons(completion: @escaping (Result<[PokemonEntity], APIError>) -> Void) {
        callFetchPokemons += 1

        if let error = error {
            completion(.failure(error))
        } else {
            completion(.success(pokemons))
        }
    }
}

final class GetPokemonUseCaseTests: XCTestCase {
    private let repositoryStub = RepositoryStub()
    private lazy var sut = GetPokemonList(repository: repositoryStub)

    func testGetPokemonList_WhenSuccessfullyGetPokemonList_ShouldReturnPokemonList() {
        repositoryStub.setPokemons(PokemonEntityDummy.list())

        sut.getPokemonList { [weak self] result in
            switch result {
            case .success(let pokemons):
                XCTAssertEqual(pokemons, PokemonEntityDummy.list())
                XCTAssertEqual(self?.repositoryStub.callFetchPokemons, 1)
                XCTAssertNil(self?.repositoryStub.error)
            case .failure:
                XCTFail()
            }
        }
    }

    func testGetPokemonList_WhenReceiveError_ShouldReturnError() {
        repositoryStub.setError(.generic)

        sut.getPokemonList { [weak self] result in
            switch result {
            case .success(_):
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error, APIError.generic)
                XCTAssertEqual(self?.repositoryStub.callFetchPokemons, 1)
            }
        }
    }
}
