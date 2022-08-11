//
//  StringExtensions.swift
//  Happy Donuts
//
//  Created by Jacob Aguilar on 10-08-22.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
