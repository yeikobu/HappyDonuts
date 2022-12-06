//
//  UserExtraDataModel.swift
//  Happy Donuts
//
//  Created by Jacob Aguilar on 02-09-22.
//

import Foundation

struct UserExtraDataModel: Decodable, Encodable {
    var phone: String = ""
    var name: String = ""
    var location: String = ""
}
