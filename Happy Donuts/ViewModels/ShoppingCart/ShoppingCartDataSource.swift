//
//  ShoppingCartDataSource.swift
//  Happy Donuts
//
//  Created by Jacob Aguilar on 01-12-22.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

final class ShoppingCartDataSource {
    private let database = Firestore.firestore()
    private let collection = "Orders"
    private let uid = String(describing: Auth.auth().currentUser?.uid)
    private let subColleciton = "userOrders"
    
    @MainActor
    func setOrderedCart(orderModel: OrderModel) {
        do {
            try database.collection(collection).document(uid).collection(subColleciton).document("order\(orderModel.dateID)").setData(from: orderModel)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @MainActor
    func getUserOrders() async -> [OrderModel] {
        var orders = [OrderModel]()
        
        do {
            let query = try await database.collection(collection).document(uid).collection(subColleciton).getDocuments()
            let documents = query.documents.compactMap({$0})
            let ordersData = documents.map { try? $0.data(as: OrderModel.self)}.compactMap{$0}
            orders = ordersData
        } catch {
            print(error.localizedDescription)
        }
        
        return orders
    }
    
    func setOrderAsFinished(orderModel: OrderModel) {
        do {
            try database.collection(collection).document(uid).collection(subColleciton).document("order\(orderModel.dateID)").setData(from: orderModel)
        } catch {
            print(error.localizedDescription)
        }
    }
}
