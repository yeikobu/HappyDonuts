//
//  ShoppingCartViewModel.swift
//  Happy Donuts
//
//  Created by Jacob Aguilar on 21-11-22.
//

import Foundation


final class ShoppingCartViewModel: ObservableObject {
    
    @Published var cartItems = [DonutModel]()
    
    func addToShoppingCart(donut: DonutModel) {
        cartItems.append(donut)
        print("Donut: \(donut)")
    }
    
}
