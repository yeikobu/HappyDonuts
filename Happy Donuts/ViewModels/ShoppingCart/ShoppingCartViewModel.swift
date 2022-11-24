//
//  ShoppingCartViewModel.swift
//  Happy Donuts
//
//  Created by Jacob Aguilar on 21-11-22.
//

import Foundation


final class ShoppingCartViewModel: ObservableObject {
    
    @Published var cartItems: [CartItemModel] = []
    
    func addToShoppingCart(donut: DonutModel, quantity: Int, quantityPrice: Int) {
        cartItems.append(CartItemModel(donut: donut, quantity: quantity, quantityPrice: quantityPrice))
    }
    
}
