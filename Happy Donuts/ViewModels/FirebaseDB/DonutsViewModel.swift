//
//  DonutsViewModel.swift
//  Happy Donuts
//
//  Created by Jacob Aguilar on 08-08-22.
//

import Foundation

final class DonutsViewModel: ObservableObject {
    private let donutsRepository: DonutsRepository
    private let homeViewModel: HomeViewModel = HomeViewModel()
    @Published var donutsModel: [DonutModel] = []
    @Published var glaseadaDonuts: [DonutModel] = []
    @Published var chocolateDonuts: [DonutModel] = []
    @Published var rellenaDonuts: [DonutModel] = []
    @Published var normalDonuts: [DonutModel] = []
    @Published var lastItem: String = ""
    
    
    init(donutsRepository: DonutsRepository = DonutsRepository()) {
        self.donutsRepository = donutsRepository
        
        getAllDonuts()
        getDonutsFromSelectedCategory()
    }
    
    
    func getAllDonuts() {
        self.donutsRepository.getAllDonuts { [weak self] result in
            switch result {
            case .success(let donutModel):
                self?.donutsModel = donutModel
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    func getLastDonut() {
        self.donutsRepository.getAllDonuts { [weak self] result in
            switch result {
            case .success(let donutModel):
                if let lastItem = donutModel.last {
                    self?.lastItem = lastItem.name
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    func getDonutsFromSelectedCategory() {
        self.donutsRepository.getAllDonuts { [weak self] result in
            switch result {
            case .success(let donutModel):
                donutModel.forEach { donut in
                    
                    if donut.category == self?.homeViewModel.categories[1] {
                        self?.glaseadaDonuts.append(donut)
                        print("Donut agregada a categoria \(donut)")
                    }

                    if donut.category == self?.homeViewModel.categories[2] {
                        self?.chocolateDonuts.append(donut)
                        print("Donut agregada a categoria \(donut)")
                    }

                    if donut.category == self?.homeViewModel.categories[3] {
                        self?.rellenaDonuts.append(donut)
                        print("Donut agregada a categoria \(donut)")
                    }

                    if donut.category == self?.homeViewModel.categories[4] {
                        self?.normalDonuts.append(donut)
                        print("Donut agregada a categoria \(donut)")
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
