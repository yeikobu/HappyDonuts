//
//  DonutModel.swift
//  Happy Donuts
//
//  Created by Jacob Aguilar on 08-08-22.
//

import Foundation

struct DonutModel: Decodable, Hashable, Encodable {
    var name: String = ""
    var description: String = ""
    var price: Int = 0
    var category: String = ""
    var sellCount: Int = 0
    var imgUrl: String = ""
}
