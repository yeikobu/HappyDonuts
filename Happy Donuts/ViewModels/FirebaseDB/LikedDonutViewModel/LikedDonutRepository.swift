//
//  DonutsRepository.swift
//  Happy Donuts
//
//  Created by Jacob Aguilar on 23-08-22.
//

import Foundation

final class LikedDonutRepository {
    private let likedDonutDataSource: LikedDonutDataSource
    
    init(likedDonutDataSource: LikedDonutDataSource = LikedDonutDataSource()) {
        self.likedDonutDataSource = likedDonutDataSource
    }
    
    func getLikedDonuts(completion: @escaping (Result<[DonutModel], Error>) -> Void) {
        self.likedDonutDataSource.getLikedDonuts(completion: completion)
    }
}
