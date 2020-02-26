//
//  AirportAPI.swift
//  AirportFinder
//
//  Created by Israel Jonathan Velázquez Sánchez on 2/26/20.
//  Copyright © 2020 Siker. All rights reserved.
//

import Foundation

enum AirportAPI: Endpoint, URLRequestConvertible {
    case search(radius: Int, location: Location)

    var baseURL: URL {
        return Environment.baseURL(hostType: .rapiappi)
    }

    var path: String {
        switch self {
        case .search:
            return "api/airports/by-radius"
        }
    }

    var method: HTTPMethod {
        return .get
    }

    var params: [String: String]? {
        switch self {
        case .search(radius: let radius, location: let location):
            return [
                "radius": String(radius),
                "lng": String(location.longitude),
                "lat": String(location.latitude)
            ]
        }
    }

    var body: [String: String]? {
        return nil
    }

    var headers: [String : String]? {
        return [
            "x-rapidapi-host": "cometari-airportsfinder-v1.p.rapidapi.com",
            "x-rapidapi-key": "587948c69bmsh6bd1647577a4f54p168162jsn7979dc431956"
        ]
    }

    func asURLRequest() throws -> URLRequest {

        var urlComponents = URLComponents(url: baseURL.appendingPathComponent(path),
                                          resolvingAgainstBaseURL: false)

        if let params = params {
            let queryItems = params.map { URLQueryItem(name: $0, value: $1) }
            urlComponents?.queryItems = queryItems
        }

        guard let url = urlComponents?.url else {
            throw EndpointError.badBaseURL
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue

        if let headers = headers {
            headers.forEach { urlRequest.addValue($1, forHTTPHeaderField: $0) }
        }

        if let body = body {
            let jsonEncoder = JSONEncoder()
            let data = try jsonEncoder.encode(body)
            urlRequest.httpBody = data
        }

        return urlRequest
    }
}
