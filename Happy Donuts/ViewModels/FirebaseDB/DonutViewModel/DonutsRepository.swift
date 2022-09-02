//
//  DonutsRepository.swift
//  Happy Donuts
//
//  Created by Jacob Aguilar on 08-08-22.
//

import Foundation

final class DonutsRepository {
    private let donutsDataSource: DonutsDataSource
    
    init(donutsDataSource: DonutsDataSource = DonutsDataSource()) {
        self.donutsDataSource = donutsDataSource
    }
    
    func getAllDonuts(completion: @escaping (Result<[DonutModel], Error>) -> Void) {
        self.donutsDataSource.getAllDonuts(completion: completion)
    }
}
