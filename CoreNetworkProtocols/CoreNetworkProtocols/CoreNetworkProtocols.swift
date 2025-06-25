//
//  CoreNetworkProtocols.swift
//  CoreNetworkProtocols
//
//  Created by Gabriel Ferraz Fontes on 25/06/25.
//

public enum APIError: Error {
    case generic
    case noData
    case urlUnknown
    case decoderError
}

public protocol APIRepository {
    func fetch<T:Decodable>(endpoint: String, completion: @escaping (Result<T, APIError>) -> Void)
}

