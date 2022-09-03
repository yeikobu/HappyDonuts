//
//  UserExtraDataModel.swift
//  Happy Donuts
//
//  Created by Jacob Aguilar on 02-09-22.
//

import Foundation

struct UserExtraDataModel: Decodable, Encodable {
    var userPhoneNumber: String = "Ingresa tu número de contacto"
    var userName: String = "Ingresa tu nombre de contacto"
    var direction: String = "Ingresa tu dirección"
}
