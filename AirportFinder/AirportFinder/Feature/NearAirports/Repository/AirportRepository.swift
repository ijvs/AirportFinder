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
    func getAirportList(inLocation: Location,
                        radius: Int,
                        completion: @escaping (GetAiportListResult) -> Void)
}

class AirportRepositoryImp: AirportRepository {

    func getAirportList(inLocation: Location,
                        radius: Int,
                        completion: @escaping (GetAiportListResult) -> Void) {
        
    }
}
