//
//  LikedDonutViewModel.swift
//  Happy Donuts
//
//  Created by Jacob Aguilar on 23-08-22.
//

import Foundation

final class LikedDonutViewModel: ObservableObject {
    private let likedDonutRepository: LikedDonutRepository
    private let donutsViewModel: DonutsViewModel = DonutsViewModel()
    
    @Published var likedDonuts: [DonutModel] = []
    @Published var likedDonutsQuantity: Int = 0
    @Published var isDonutLiked: Bool = false
    
    init(likedDonutRepository: LikedDonutRepository = LikedDonutRepository()) {
        self.likedDonutRepository = likedDonutRepository
    }
    
    
    func getLikedDonuts() {
        self.likedDonutRepository.getLikedDonuts { [weak self] result in
            switch result {
            case .success(let likedDonuts):
                self?.likedDonuts = likedDonuts
                self?.likedDonutsQuantity = self?.likedDonuts.count ?? 0
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    func addToLikedDonuts(name: String, description: String, imgUrl: String, category: String, price: Int, sellCount: Int) {
        self.likedDonutRepository.addToLikedDonuts(name: name, description: description, imgUrl: imgUrl, category: category, price: price, sellCount: sellCount) { [weak self] result in
            switch result {
            case .success( _):
                self?.isDonutLiked = true
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    func checkIfDonutAlreadyLiked(donut: DonutModel) async -> Bool {
        return await self.likedDonutRepository.checkIfDonutAlreadyLiked(donut: donut)
    }
    
    
    func deleteDonutFromLikedDonuts(name: String) async {
        if await self.likedDonutRepository.deleteDonutFromLikedDonuts(name: name) {
            print("removed!")
        }
    }
    
}
