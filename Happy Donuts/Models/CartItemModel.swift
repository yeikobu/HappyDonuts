//
//  ShoppingCartModel.swift
//  Happy Donuts
//
//  Created by Jacob Aguilar on 22-11-22.
//

import Foundation

struct CartItemModel: Hashable, Identifiable {
    var id = UUID()
    var donut: DonutModel = DonutModel()
    var quantity: Int = 1
    var quantityPrice: Int = 1000
    
}
