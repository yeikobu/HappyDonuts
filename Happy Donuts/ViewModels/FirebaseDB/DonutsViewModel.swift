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
    @Published var imgUrl: String = ""
    @Published var name: String = ""
    @Published var price: Int = 0
    @Published var description: String = ""
    @Published var donutModel: DonutModel = DonutModel()
    
    
    init(donutsRepository: DonutsRepository = DonutsRepository()) {
        self.donutsRepository = donutsRepository
        
        getAllDonuts()
        getDonutsFromSelectedCategory()
    }
    
    
    /// This method get all the donuts data from Firebase and saves the data in one array of DonutModels
    /// - Returns: Void
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
    
    
    /// This method get the last donut and save it in a variable.
    /// - Returns: Void
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
    
    
    /// This method save the data in diferents arrays depending of the categorie in order to be used like a filter in the view.
    /// - Returns: Void
    func getDonutsFromSelectedCategory() {
        self.donutsRepository.getAllDonuts { [weak self] result in
            switch result {
            case .success(let donutModel):
                donutModel.forEach { donut in
                    
                    if donut.category == self?.homeViewModel.categories[1] {
                        self?.glaseadaDonuts.append(donut)
                    }

                    if donut.category == self?.homeViewModel.categories[2] {
                        self?.chocolateDonuts.append(donut)
                    }

                    if donut.category == self?.homeViewModel.categories[3] {
                        self?.rellenaDonuts.append(donut)
                    }

                    if donut.category == self?.homeViewModel.categories[4] {
                        self?.normalDonuts.append(donut)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    /// This method save the data in diferents variables in order to be used in the View.
    /// - Returns: Void
    func setDataFromSelectedDonut(imgUrl: String, name: String, price: Int, description: String, donutModel: DonutModel) {
        self.imgUrl = imgUrl
        self.name = name
        self.price = price
        self.description = description
        self.donutModel = donutModel
    }
    
    
    func countDonuts(categoryElements: [DonutModel]) -> Int {
        return categoryElements.count
    }
}
