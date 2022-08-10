//
//  DonutsViewModel.swift
//  Happy Donuts
//
//  Created by Jacob Aguilar on 08-08-22.
//

import Foundation

final class DonutsViewModel: ObservableObject {
    private let donutsRepository: DonutsRepository
    @Published var donutModel: [DonutModel] = []
//    @Published var name: String = "Rosa estrellada"
//    @Published var price: Int = 1400
//    @Published var category: String = "glaseada"
//    @Published var sellCount: Int = 0
//    @Published var imgUrl: String = "https://firebasestorage.googleapis.com/v0/b/happydonutsapp.appspot.com/o/Rosa%20estrellada.png?alt=media&token=d4b9e7ef-ef9c-4619-b1ed-12b4591a12c4"
//    @Published var description: String = "Donut bañada en manjar con sufflés crocantes de chocolate y salsa de chocolate. \nEsta donut fue creada pensando en el paladar de los fanáticos de lo crocante y el chocolate."
    
    
    init(donutsRepository: DonutsRepository = DonutsRepository()) {
        self.donutsRepository = donutsRepository
    }
    
    func getAllDonuts() {
        self.donutsRepository.getAllDonuts { [weak self] result in
            switch result {
            case .success(let donutModel):
                print("Donuts: \(donutModel)")
                self?.donutModel = donutModel
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
