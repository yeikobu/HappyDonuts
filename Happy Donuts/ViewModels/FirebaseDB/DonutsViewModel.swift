//
//  DonutsViewModel.swift
//  Happy Donuts
//
//  Created by Jacob Aguilar on 08-08-22.
//

import Foundation

final class DonutsViewModel: ObservableObject {
    private let donutsRepository: DonutsRepository
    @Published var donutsModel: [DonutModel] = []
    @Published var lastItem: String = ""
    
    
    init(donutsRepository: DonutsRepository = DonutsRepository()) {
        self.donutsRepository = donutsRepository
        
        getAllDonuts()
    }
    
    
    func getAllDonuts() {
        self.donutsRepository.getAllDonuts { [weak self] result in
            switch result {
            case .success(let donutModel):
                print("Donuts: \(donutModel)")
                self?.donutsModel = donutModel
                if let lastItem = donutModel.last {
                    self?.lastItem = lastItem.name
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
