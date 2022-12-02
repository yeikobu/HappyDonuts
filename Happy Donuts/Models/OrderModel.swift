//
//  OrderModel.swift
//  Happy Donuts
//
//  Created by Jacob Aguilar on 01-12-22.
//

import Foundation

struct OrderModel: Hashable, Identifiable, Encodable, Decodable {
    var id:UUID = UUID()
    var cartItems: [CartItemModel] = []
    var finalPrice: Int = 0
    var date: String = ""
    var location: String = ""
    var status: Int = 0
}
