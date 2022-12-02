//
//  ShoppingCartRepository.swift
//  Happy Donuts
//
//  Created by Jacob Aguilar on 01-12-22.
//

import Foundation

final class ShoppingCartRepository {
    private let shoppingCartDataSource: ShoppingCartDataSource
    
    init(shoppingCartDataSource: ShoppingCartDataSource = ShoppingCartDataSource()) {
        self.shoppingCartDataSource = shoppingCartDataSource
    }
    
    @MainActor
    func setOrderedCart(orderModel: OrderModel) {
        self.shoppingCartDataSource.setOrderedCart(orderModel: orderModel)
    }
    
    @MainActor
    func getUserOrders() async -> [OrderModel] {
        await self.shoppingCartDataSource.getUserOrders()
    }
    
}
