//
//  LikedDonutDataSource.swift
//  Happy Donuts
//
//  Created by Jacob Aguilar on 23-08-22.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth

final class LikedDonutDataSource {
    private let database = Firestore.firestore()
    private let collection = "Liked"
    private let uid = String(describing: Auth.auth().currentUser?.uid)
    private let subColleciton = "likedDonuts"
    
    func getLikedDonuts(completion: @escaping (Result<[DonutModel], Error>) -> Void) {
        database.collection(collection).document(uid).collection(subColleciton).addSnapshotListener { query, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            
            guard let documents = query?.documents.compactMap({$0}) else {
                completion(.success([]))
                return
            }
            
            let likedDonuts = documents.map { try? $0.data(as: DonutModel.self)}.compactMap{ $0 }
            completion(.success(likedDonuts))
        }
    }
    
    
    func addToLikedDonuts(name: String, description: String, imgUrl: String, category: String, price: Int, sellCount: Int, completion: @escaping (Result<DonutModel, Error>) -> Void) {
        let likedDonut = DonutModel(name: name, description: description, price: price, category: category, sellCount: sellCount, imgUrl: imgUrl)
        
        do {
            try database.collection(collection).document(uid).collection(subColleciton).document(name).setData(from: likedDonut)
            
            completion(.success(likedDonut))
        } catch {
            completion(.failure(error))
        }
    }
    
    
    @MainActor
    func checkIfDonutAlreadyLiked(donut: DonutModel) async -> Bool {
        var donutModel = [DonutModel]()
        do {
            let query = try await database.collection(collection).document(uid).collection(subColleciton).getDocuments()
            let documents = query.documents.compactMap({$0})
            let donuts = documents.map { try? $0.data(as: DonutModel.self)}.compactMap{$0}
            donutModel = donuts
        } catch {
            print(error.localizedDescription)
        }
        return donutModel.contains(donut)
    }
    
    
    @MainActor
    func deleteDonutFromLikedDonuts(name: String) async -> Bool {
        var isRemoved: Bool = false
        if let query = try? await database.collection(collection).document(uid).collection(subColleciton).document(name).delete() {
            print(query)
            isRemoved = true
            return isRemoved
        }
        return isRemoved
    }
}
