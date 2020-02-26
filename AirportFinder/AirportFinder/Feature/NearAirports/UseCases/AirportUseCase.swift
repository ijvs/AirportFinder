//
//  AirportUseCase.swift
//  AirportFinder
//
//  Created by Israel Jonathan Velázquez Sánchez on 2/25/20.
//  Copyright © 2020 Siker. All rights reserved.
//

import Foundation

typealias GetAirportsResult = Result<[Airport], Error>

protocol GetAirportsUseCase {
    func getNearAirports(byRadius radius: Int,
                         location: Location,
                         completion: @escaping (GetAirportsResult) -> Void)
}

protocol AirportUseCase: GetAirportsUseCase { }

class AirportUseCaseImp: AirportUseCase {

    let airportWorker: AirportRepository

    init(airportWorker: AirportRepository = AirportRepositoryImp()) {
        self.airportWorker = airportWorker
    }

    func getNearAirports(byRadius radius: Int,
                         location: Location,
                         completion: @escaping (GetAirportsResult) -> Void) {
        airportWorker.getAirportList(byRadius: radius, location: location, completion: completion)
    }
}
