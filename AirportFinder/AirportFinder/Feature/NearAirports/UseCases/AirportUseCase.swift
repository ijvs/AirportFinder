//
//  AirportUseCase.swift
//  AirportFinder
//
//  Created by Israel Jonathan Velázquez Sánchez on 2/25/20.
//  Copyright © 2020 Siker. All rights reserved.
//

import Foundation

typealias GetAirportsResult = Result<Void, Error>

protocol GetAirportsUseCase {
    func getNearAirports(inLocation location: Location,
                         radius: Int,
                         completion: @escaping (GetAirportsResult) -> Void)
}

protocol AirportUseCase: GetAirportsUseCase { }

class AirportUseCaseImp: AirportUseCase {

    let airportWorker: AirportRepository

    init(airportWorker: AirportRepository = AirportRepositoryImp()) {
        self.airportWorker = airportWorker
    }

    func getNearAirports(inLocation location: Location,
                         radius: Int,
                         completion: @escaping (GetAirportsResult) -> Void) {
        airportWorker.getAirportList(inLocation: location, radius: radius) { (result) in
            switch result {
            case .success:
                break
            case .failure:
                break
            }
        }
    }
}
