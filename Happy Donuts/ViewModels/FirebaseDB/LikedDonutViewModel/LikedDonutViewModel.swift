//
//  LikedDonutViewModel.swift
//  Happy Donuts
//
//  Created by Jacob Aguilar on 23-08-22.
//

import Foundation

final class LikedDonutViewModel: ObservableObject {
    private let likedDonutRepository: LikedDonutRepository
    
    @Published var likedDonuts: [DonutModel] = []
    @Published var likedDonutsQuantity: Int = 0
    
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
}
