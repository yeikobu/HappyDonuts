//
//  DonutsDataSource.swift
//  Happy Donuts
//
//  Created by Jacob Aguilar on 08-08-22.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

final class DonutsDataSource {
    private let database: Firestore = Firestore.firestore()
    private let collection: String = "Donuts"
    
    func getAllDonuts(completion: @escaping(Result<[DonutModel], Error>) -> Void) {
        database.collection(collection).addSnapshotListener { query, error in
            if let error = error {
                print("Error \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            
            guard let documents = query?.documents.compactMap({$0}) else {
                completion(.success([]))
                return
            }
            
            let donuts = documents.map { try? $0.data(as: DonutModel.self) }.compactMap { $0 }
            
            completion(.success(donuts))
        }
    }
}
