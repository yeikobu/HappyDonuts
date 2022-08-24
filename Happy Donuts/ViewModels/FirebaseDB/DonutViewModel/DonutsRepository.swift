//
//  DonutsRepository.swift
//  Happy Donuts
//
//  Created by Jacob Aguilar on 08-08-22.
//

import Foundation
import Lottie

final class DonutsRepository {
    private let donutsDataSource: DonutsDataSource
    
    init(donutsDataSource: DonutsDataSource = DonutsDataSource()) {
        self.donutsDataSource = donutsDataSource
    }
    
    deinit {
        print("Eliminando referencia Donuts Repository")
    }
    
    func getAllDonuts(completion: @escaping (Result<[DonutModel], Error>) -> Void) {
        self.donutsDataSource.getAllDonuts(completion: completion)
    }
}
