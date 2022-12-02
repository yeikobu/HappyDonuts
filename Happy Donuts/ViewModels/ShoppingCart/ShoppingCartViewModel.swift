//
//  ShoppingCartViewModel.swift
//  Happy Donuts
//
//  Created by Jacob Aguilar on 21-11-22.
//

import Foundation
import SwiftUI

final class ShoppingCartViewModel: ObservableObject {
    
    @Published var cartItems: [CartItemModel] = []
    @Published var userDonutOrders: [OrderModel] = []
    @Published var donutsTotalPrice: Int = 0
    @Published var currentOrderUUID = UUID()
    @Published var currentOrderStatus = 0
    private let profileViewModel = ProfileViewModel()
    private let shoppingCartRepository: ShoppingCartRepository
    var deliveryPrice: Int = 4000
    var errorMessage: String = ""
    @Published var showUserInfoError: Bool = false
    @Published var isCheckoutButtonTapped: Bool = false
    
    init(shoppingCartRepository: ShoppingCartRepository = ShoppingCartRepository()) {
        self.shoppingCartRepository = shoppingCartRepository
    }
    
    func addToShoppingCart(donut: DonutModel, quantity: Int, quantityPrice: Int) {
        cartItems.append(CartItemModel(donut: donut, quantity: quantity, quantityPrice: quantityPrice))
    }
    
    func sumTotalPrice() {
        self.donutsTotalPrice = cartItems.map({$0.quantityPrice}).reduce(0, +)
    }
    
    func removeFromCart(id: UUID) {
        if let itemIndex = self.cartItems.firstIndex(where: {$0.id == id}) {
            cartItems.remove(at: itemIndex)
        }
    }
    
    @MainActor
    func checkUserDataCompleted() async {
        await profileViewModel.getUserExtraData()
        print(profileViewModel.userExtraDataModel)
        if (profileViewModel.userExtraDataModel.name.isEmpty || profileViewModel.userExtraDataModel.phone.isEmpty || profileViewModel.userExtraDataModel.location.isEmpty) {
            withAnimation(.easeIn) {
                self.showUserInfoError = true
            }
            errorMessage = "Debes completar todos los datos de tu perfil antes de proceder con el pago"
        } else if(profileViewModel.userExtraDataModel.phone.count < 11) {
            withAnimation(.easeIn) {
                self.showUserInfoError = true
            }
            errorMessage = "El número de teléfono debe contener al menos 11 números."
        } else {
            self.showUserInfoError = false
            errorMessage = ""
        }
        print(errorMessage)
    }
    
    @MainActor
    func setOrderedCart(orderModel: OrderModel) {
        self.shoppingCartRepository.setOrderedCart(orderModel: orderModel)
        self.currentOrderUUID = orderModel.id
    }
    
    @MainActor
    func getUserOrders() async {
        let userOrders = await self.shoppingCartRepository.getUserOrders()
        self.userDonutOrders = userOrders
    }
    
}
