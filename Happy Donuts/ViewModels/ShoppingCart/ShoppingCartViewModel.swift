//
//  ShoppingCartViewModel.swift
//  Happy Donuts
//
//  Created by Jacob Aguilar on 21-11-22.
//

import Foundation


final class ShoppingCartViewModel: ObservableObject {
    
    @Published var cartItems: [CartItemModel] = []
    @Published var donutsTotalPrice: Int = 0
    var deliveryPrice: Int = 4000
    
    func addToShoppingCart(donut: DonutModel, quantity: Int, quantityPrice: Int) {
        cartItems.append(CartItemModel(donut: donut, quantity: quantity, quantityPrice: quantityPrice))
    }
    
    func sumTotalPrice() {
        self.donutsTotalPrice = cartItems.map({$0.quantityPrice}).reduce(0, +)
    }
    
    func removeFromCart(id: UUID) {
        if let itemIndex = self.cartItems.firstIndex(where: {$0.id == id}) {
            cartItems.remove(at: itemIndex)
        }
    }
    
}
