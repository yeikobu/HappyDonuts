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
    
    func addToLikedDonuts(name: String, description: String, imgUrl: String, category: String, price: Int, sellCount: Int, completion: @escaping (Result<DonutModel, Error>) -> Void) {
        self.likedDonutDataSource.addToLikedDonuts(name: name, description: description, imgUrl: imgUrl, category: category, price: price, sellCount: sellCount, completion: completion)
    }
}
