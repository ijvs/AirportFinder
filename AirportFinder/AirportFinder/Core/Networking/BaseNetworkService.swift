//
//  BaseNetworkService.swift
//  AirportFinder
//
//  Created by Israel Jonathan Velázquez Sánchez on 2/25/20.
//  Copyright © 2020 Siker. All rights reserved.
//

import Foundation

typealias ParserMethod<Model> = (Data?) throws -> Model

class BaseNetworkService<Model: Decodable> {

    func make(request: URLRequest,
              completion: @escaping (Result<Model, Error>) -> Void,
              parser: ParserMethod<Model>? = nil) {

        let session: URLSession = URLSession(configuration: URLSessionConfiguration.default)
        session.dataTask(with: request) { [weak self] (data, _, error) in

            guard let self = self, error == nil else {
                completion(.failure(error ?? ParsingError.noDataToParse))
                return
            }
            //TODO: Manage the response error code.
            let parserMethod = parser ?? self.genericParser
            do {
                let model = try parserMethod(data)
                completion(.success(model))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    private var genericParser: ParserMethod<Model> = { data in
        guard let json = data else { throw ParsingError.noDataToParse }
        return try JSONDecoder().decode(Model.self, from: json)
    }
}
