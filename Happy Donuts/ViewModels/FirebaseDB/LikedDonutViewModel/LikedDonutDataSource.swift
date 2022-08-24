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
    private let uid = String(describing: Auth.auth().currentUser!.uid)
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
}
