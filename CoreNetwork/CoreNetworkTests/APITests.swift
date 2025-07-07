//
//  APITests.swift
//  CoreNetworkTests
//
//  Created by Gabriel Ferraz Fontes on 25/06/25.
//

import XCTest
import CoreNetworkProtocols
@testable import CoreNetwork

struct PokemonDummy: Decodable {
    let id: Int
    let name: String
}

final class NetworkSessionMock: NetworkSession {
    var data: Data?
    var error: Error?
    var urlResponse: URLResponse?

    func loadData(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        completion(data, urlResponse, error)
    }
}

final class CoreNetworkTests: XCTestCase {
    lazy var urlValidPokemon = Bundle(for: type(of: self)).url(forResource: "pokemonMock", withExtension: "json")
    lazy var urlInvalidPokemon = Bundle(for: type(of: self)).url(forResource: "invalidPokemonMock", withExtension: "json")
    let netWorkSessionMock = NetworkSessionMock()
    private lazy var sut = API(networkSession: netWorkSessionMock)

    func testFetch_WhenInvalidURL_ShouldReturnInvalidURLError() {
        let expetation = XCTestExpectation(description: "Url Error")
        netWorkSessionMock.error = APIError.urlUnknown

        sut.fetch(endpoint: "") { (result: Result<PokemonDummy, APIError>) in
            switch result {
            case .success(_):
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error, APIError.urlUnknown)
            }
            expetation.fulfill()
        }

        wait(for: [expetation], timeout: 5.0)
    }

    func testFetch_WhenNoData_ShouldReturnNoDataError() {
        let expetation = XCTestExpectation(description: "No Data Error")
        netWorkSessionMock.error = APIError.noData

        sut.fetch(endpoint: "https://pokeapi.co/") { (result: Result<PokemonDummy, APIError>) in
            switch result {
            case .success(_):
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error, APIError.noData)
            }
            expetation.fulfill()
        }

        wait(for: [expetation], timeout: 5.0)
    }

    func testFetch_WhenDecoderFailed_ShouldReturnDecoderError() {
        let expetation = XCTestExpectation(description: "Decoder Error")
        netWorkSessionMock.error = APIError.decoderError
        let url = try! XCTUnwrap(urlInvalidPokemon)
        netWorkSessionMock.data = try? Data(contentsOf: url)

        sut.fetch(endpoint: "https://pokeapi.co/") { (result: Result<PokemonDummy, APIError>) in
            switch result {
            case .success(_):
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error, APIError.decoderError)
            }
            expetation.fulfill()
        }

        wait(for: [expetation], timeout: 5.0)
    }

    func testFetch_WhenSuccess_ShouldReturnValueDecoded() {
        let expetation = XCTestExpectation(description: "Success")
        let url = try! XCTUnwrap(urlValidPokemon)
        netWorkSessionMock.data = try? Data(contentsOf: url)

        sut.fetch(endpoint: "https://pokeapi.co/") { (result: Result<PokemonDummy, APIError>) in
            switch result {
            case .success(let pokemon):
                XCTAssertEqual(pokemon.id, 132)
                XCTAssertEqual(pokemon.name, "ditto")
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expetation.fulfill()
        }

        wait(for: [expetation], timeout: 5.0)
    }
}
