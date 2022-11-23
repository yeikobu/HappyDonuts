//
//  ShoppingCartModel.swift
//  Happy Donuts
//
//  Created by Jacob Aguilar on 22-11-22.
//

import Foundation

struct ShoppingCartModel: Hashable, Identifiable {
    var id = UUID()
    var donut: DonutModel
    var quantity: Int
    var quantityPrice: Int
}
