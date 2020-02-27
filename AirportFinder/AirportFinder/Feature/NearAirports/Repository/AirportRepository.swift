//
//  AirportsWorker.swift
//  AirportFinder
//
//  Created by Israel Jonathan Velázquez Sánchez on 2/25/20.
//  Copyright © 2020 Siker. All rights reserved.
//

import Foundation

typealias GetAiportListResult = Result<[Airport], Error>

protocol AirportRepository {
    func getAirportList(byRadius radius: Int,
                        location: Location,
                        completion: @escaping (GetAiportListResult) -> Void)
}

class AirportRepositoryImp: BaseNetworkService<[Airport]>, AirportRepository {

    func getAirportList(byRadius radius: Int,
                        location: Location,
                        completion: @escaping (GetAiportListResult) -> Void) {
        do {
            let request = try AirportAPI.search(radius: radius, location: location).asURLRequest()
            make(request: request, completion: completion)
        } catch {
            completion(.failure(error))
        }
    }
}
