//
//  ShoppingCartViewModel.swift
//  Happy Donuts
//
//  Created by Jacob Aguilar on 21-11-22.
//

import Foundation


final class ShoppingCartViewModel: ObservableObject {
    
    @Published var cartItems: [ShoppingCartModel] = []
    
    func addToShoppingCart(donut: DonutModel, quantity: Int, quantityPrice: Int) {
        cartItems.append(ShoppingCartModel(donut: donut, quantity: quantity, quantityPrice: quantityPrice))
        printItems()
    }
    
    func printItems() {
        self.cartItems.forEach { item in
            print(item.donut.name)
        }
    }
}
