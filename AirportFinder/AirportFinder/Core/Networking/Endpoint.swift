//
//  Endpoint.swift
//  AirportFinder
//
//  Created by Israel Jonathan Velázquez Sánchez on 2/26/20.
//  Copyright © 2020 Siker. All rights reserved.
//

import Foundation

protocol Endpoint {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var params: [String: String]? { get }
    var body: [String: String]? { get }
    var headers: [String: String]? { get }
}

enum EndpointError: Error {
    case badBaseURL
}
