//
//  DonutModel.swift
//  Happy Donuts
//
//  Created by Jacob Aguilar on 08-08-22.
//

import Foundation

struct DonutModel: Decodable, Hashable {
    let name: String
    let description: String
    let price: Int
    let category: String
    let sellCount: Int
    let imgUrl: String
}
