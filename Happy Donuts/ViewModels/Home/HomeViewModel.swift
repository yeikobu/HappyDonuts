//
//  HomeView.swift
//  Happy Donuts
//
//  Created by Jacob Aguilar on 02-08-22.
//

import Foundation

final class HomeViewModel: ObservableObject {
    @Published var categories: [String] = ["populares", "glaseadas", "chocolate", "rellenas","normal"]
    
}
