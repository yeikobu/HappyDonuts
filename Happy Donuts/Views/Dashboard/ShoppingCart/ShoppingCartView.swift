//
//  ShoppingCartView.swift
//  Happy Donuts
//
//  Created by Jacob Aguilar on 21-11-22.
//

import SwiftUI

struct ShoppingCartView: View {
    
    @EnvironmentObject var shoppingCartViewModel: ShoppingCartViewModel
    @StateObject var locationViewModel: LocationViewModel = LocationViewModel()
    @StateObject var profileViewModel: ProfileViewModel = ProfileViewModel()
    @StateObject var haptics: Haptics = Haptics()
    @State private var isDelivery = false
    @State private var isDeliveryToCurrentLocation = false
    @State private var isMapSHowing = false
    @Namespace var animation
    
    var body: some View {
        ZStack {
            VStack {
                ZStack {
                    Rectangle()
                        .frame(height: 140, alignment: .center)
                        .cornerRadius(35, corners: [.bottomLeft, .bottomRight])
                        .foregroundColor(Color("blue"))
                    
                    Image("logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 123, height: 76, alignment: .center)
                        .padding(.top, 30)
                }
                .ignoresSafeArea()
                
                VStack(alignment: .leading) {
                    VStack(alignment: .leading) {
                        Text("Confirma tu pedido")
                            .font(.system(size: 24, weight: .black, design: .rounded))
                    }
                    .frame(alignment: .leading)
                    .padding(.top, -30)
                    
                    ScrollView(showsIndicators: false) {
                        if shoppingCartViewModel.cartItems.count > 0 {
                            VStack(alignment: .leading) {
                                ForEach(shoppingCartViewModel.cartItems) { item in
                                    HStack {
                                        Spacer()
                                        
                                        ItemsCardView(cartItemModel: item)
                                            .padding(.top, 5)
                                        
                                        Spacer()
                                    }
                                }
                            }
                            
                            Text("¿Cómo deseas obtener tu pedido?")
                                .font(.system(size: 20, weight: .bold, design: .rounded))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.top, 20)
                            
                            VStack {
                                HStack {
                                    Text("Retirar en la tienda")
                                        .font(.system(size: 16, weight: .semibold, design: .rounded))
                                    
                                    Spacer()
                                    
                                    ZStack {
                                        Rectangle()
                                            .frame(width: 20, height: 20)
                                            .foregroundColor(Color("switchBackground"))
                                            .cornerRadius(20)
                                            .shadow(color: Color("shadow"), radius: 0.5, x: 0, y: 1)
                                            .shadow(color: Color("shadow"), radius: 0.5, x: 0, y: -0)
                                            .shadow(color: Color("shadow"), radius: 0.5, x: 1, y: 0)
                                            .shadow(color: Color("shadow"), radius: 0.5, x: -1, y: 0)
                                            .onTapGesture {
                                                withAnimation(.easeIn) {
                                                    self.isDelivery = false
                                                    self.isDeliveryToCurrentLocation = false
                                                }
                                            }
                                        
                                        if !isDelivery && !isDeliveryToCurrentLocation {
                                            Rectangle()
                                                .frame(width: 10, height: 10)
                                                .foregroundColor(Color("blue"))
                                                .cornerRadius(20)
                                                .shadow(color: Color("shadow"), radius: 1, x: 0, y: 1)
                                                .shadow(color: Color("shadow"), radius: 1, x: 0, y: -0)
                                                .matchedGeometryEffect(id: "isdelivery", in: animation)
                                        }
                                    }
                                    .padding(.trailing, 5)
                                }
                                
                                HStack {
                                    HStack {
                                        Text("Enviar a: ")
                                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                                        
                                        if !self.profileViewModel.userExtraDataModel.location.isEmpty {
                                            Text(self.profileViewModel.userExtraDataModel.location)
                                                .font(.system(size: 16, weight: .semibold, design: .rounded))
                                        } else {
                                            Text("(Debes agregar tu dirección en tu perfil)")
                                                .font(.system(size: 14, weight: .regular, design: .rounded))
                                        }
                                    }
                                    
                                    Spacer()
                                    
                                    ZStack {
                                        Rectangle()
                                            .frame(width: 20, height: 20)
                                            .foregroundColor(Color("switchBackground"))
                                            .cornerRadius(20)
                                            .shadow(color: Color("shadow"), radius: 0.5, x: 0, y: 1)
                                            .shadow(color: Color("shadow"), radius: 0.5, x: 0, y: -0)
                                            .shadow(color: Color("shadow"), radius: 0.5, x: 1, y: 0)
                                            .shadow(color: Color("shadow"), radius: 0.5, x: -1, y: 0)
                                            .onTapGesture {
                                                withAnimation(.easeIn) {
                                                    self.isDelivery = true
                                                    self.isDeliveryToCurrentLocation = false
                                                    self.locationViewModel.selectedLocation = self.profileViewModel.userExtraDataModel.location
                                                }
                                            }
                                        
                                        if isDelivery && !isDeliveryToCurrentLocation {
                                            Rectangle()
                                                .frame(width: 10, height: 10)
                                                .foregroundColor(Color("blue"))
                                                .cornerRadius(20)
                                                .shadow(color: Color("shadow"), radius: 1, x: 0, y: 1)
                                                .shadow(color: Color("shadow"), radius: 1, x: 0, y: -0)
                                                .matchedGeometryEffect(id: "isdelivery", in: animation)
                                        }
                                    }
                                    .padding(.trailing, 5)
                                }
                                .task {
                                    await self.profileViewModel.getUserExtraData()
                                }
                                
                                HStack {
                                    if self.locationViewModel.selectedLocation == "" {
                                        Text("Ubicación diferente")
                                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                                    }
                                    
                                    if self.locationViewModel.selectedLocation != "" {
                                        Text("\(self.locationViewModel.selectedLocation)")
                                            .font(.system(size: 16, weight: .bold, design: .rounded))
                                    }
                                    
                                    
                                    Spacer()
                                    
                                    ZStack {
                                        Rectangle()
                                            .frame(width: 20, height: 20)
                                            .foregroundColor(Color("switchBackground"))
                                            .cornerRadius(20)
                                            .shadow(color: Color("shadow"), radius: 0.5, x: 0, y: 1)
                                            .shadow(color: Color("shadow"), radius: 0.5, x: 0, y: -0)
                                            .shadow(color: Color("shadow"), radius: 0.5, x: 1, y: 0)
                                            .shadow(color: Color("shadow"), radius: 0.5, x: -1, y: 0)
                                            .onTapGesture {
                                                withAnimation(.easeIn) {
                                                    self.isDelivery = true
                                                    self.isDeliveryToCurrentLocation = true
                                                    self.isMapSHowing = true
                                                }
                                            }
                                            .sheet(isPresented: self.$isMapSHowing) {
                                                LocationView()
                                            }
                                        
                                        if isDeliveryToCurrentLocation {
                                            Rectangle()
                                                .frame(width: 10, height: 10)
                                                .foregroundColor(Color("blue"))
                                                .cornerRadius(20)
                                                .shadow(color: Color("shadow"), radius: 1, x: 0, y: 1)
                                                .shadow(color: Color("shadow"), radius: 1, x: 0, y: -0)
                                                .matchedGeometryEffect(id: "isdelivery", in: animation)
                                        }
                                    }
                                    .padding(.trailing, 5)
                                }
                            }
                            
                            VStack(alignment: .trailing, spacing: 2) {
                                Text("Total en donuts: $\(self.shoppingCartViewModel.donutsTotalPrice)")
                                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                                
                                Text("Valor despacho: $\(self.isDelivery ? self.shoppingCartViewModel.deliveryPrice : 0)")
                                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                                
                                Text("Total pedido: $\(self.isDelivery ? (self.shoppingCartViewModel.deliveryPrice + self.shoppingCartViewModel.donutsTotalPrice) : self.shoppingCartViewModel.donutsTotalPrice)")
                                    .font(.system(size: 18, weight: .black, design: .rounded))
                            }
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding(.vertical, 20)
                            
                            if self.shoppingCartViewModel.isCheckoutButtonTapped {
                                LottieImage(name: "Loading", loopMode: .loop)
                                    .frame(width: 100, height: 100)
                            } else {
                                HStack {
                                    Text("Procesar pago")
                                        .font(.system(size: 16, weight: .semibold, design: .rounded))
                                    
                                    Button {
                                        self.shoppingCartViewModel.isCheckoutButtonTapped = true
                                        Task {
                                            self.haptics.likeFunctionVibration()
                                            await self.shoppingCartViewModel.checkUserDataCompleted()
                                            if !self.shoppingCartViewModel.showUserInfoError {
                                                let date = Date()
                                                let calendar = Calendar.current
                                                let currentDate = "\(calendar.component(.year, from: date))/\(calendar.component(.month, from: date))/\(calendar.component(.day, from: date)) \(calendar.component(.hour, from: date)):\(calendar.component(.minute, from: date))"
                                                let orderDate = "\(calendar.component(.year, from: date))\(calendar.component(.month, from: date))\(calendar.component(.day, from: date))\(calendar.component(.hour, from: date))\(calendar.component(.minute, from: date))\(calendar.component(.second, from: date))\(calendar.component(.nanosecond, from: date))"
                                                
                                                self.shoppingCartViewModel.setOrderedCart(orderModel: OrderModel(cartItems: self.shoppingCartViewModel.cartItems, finalPrice: (self.isDelivery ? (self.shoppingCartViewModel.deliveryPrice + self.shoppingCartViewModel.donutsTotalPrice) : self.shoppingCartViewModel.donutsTotalPrice), date: currentDate, location: self.isDelivery ? self.locationViewModel.selectedLocation : "Retiro en tienda", dateID: orderDate))
                                            } else {
                                                self.shoppingCartViewModel.isCheckoutButtonTapped = false
                                            }
                                        }
                                    } label: {
                                        VStack {
                                            Image(systemName: "creditcard.fill")
                                                .font(.system(size: 25, weight: .black, design: .rounded))
                                                .foregroundColor(Color("buttonTextColor"))
                                                .padding(4)
                                                .frame(width: 40, height: 40)
                                        }
                                        .background(Color("blue"))
                                        .cornerRadius(12)
                                        .shadow(color: Color("shadow"), radius: 1, x: 0, y: 1)
                                    }
                                }
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .padding(.bottom, 35)
                            }
                            
                        }
                    }
                    .padding(.bottom, 20)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 10)
                
                if shoppingCartViewModel.cartItems.count == 0 {
                    HStack {
                        Spacer()
                        
                        Text("Tu carrito de compras está vacío...")
                            .font(.system(size: 14, weight: .black, design: .rounded))
                        
                        Spacer()
                    }
                    .padding(.bottom, 300)
                }
                
                Spacer()
                Spacer()
                Spacer()
            }
            .foregroundColor(Color("fontColor"))
            .onAppear {
                self.shoppingCartViewModel.sumTotalPrice()
            }
            .environmentObject(self.locationViewModel)
            
            if self.shoppingCartViewModel.currentOrderStatus == 1 {
                ZStack {
                    Rectangle()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .foregroundColor(Color("background"))
                    VStack {
                        Text("Estamos Preparando tu pedido... 🍩")
                            .font(.system(size: 20, weight: .black, design: .rounded))
                        
                        LottieImage(name: "Preparing", loopMode: .loop)
                            .frame(width: 250, height: 250)
                    }
                }
                .ignoresSafeArea()
            }
            
            if self.shoppingCartViewModel.currentOrderStatus == 2 {
                ZStack {
                    Rectangle()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .foregroundColor(Color("background"))
                    VStack {
                        Text("Tu pedido está en camino")
                            .font(.system(size: 20, weight: .black, design: .rounded))
                        
                        LottieImage(name: "Deliveryman", loopMode: .loop)
                            .frame(width: 300, height: 300)
                    }
                }
                .ignoresSafeArea()
            }
            
            if self.shoppingCartViewModel.currentOrderStatus == 3 {
                ZStack {
                    Rectangle()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .foregroundColor(Color("background"))
                    VStack {
                        Text("Tu pedido está listo para retirar")
                            .font(.system(size: 20, weight: .black, design: .rounded))
                        
                        LottieImage(name: "Bag", loopMode: .loop)
                            .frame(width: 300, height: 300)
                    }
                }
                .ignoresSafeArea()
            }
            
            if self.shoppingCartViewModel.currentOrderStatus == 4 {
                ZStack {
                    Rectangle()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .foregroundColor(Color("background"))
                    VStack {
                        Text("Tu pedido ha sido entregado 🤤")
                            .font(.system(size: 20, weight: .black, design: .rounded))
                        
                        Button {
                            self.shoppingCartViewModel.cartItems = []
                            self.shoppingCartViewModel.isCheckoutButtonTapped = false
                            self.shoppingCartViewModel.userDonutOrders.forEach { order in
                                if order.id == self.shoppingCartViewModel.currentOrderUUID {
                                    self.shoppingCartViewModel.currentOrderStatus = order.status
                                    print(order.status)
                                    var currentOrder = order
                                    currentOrder.status = 5
                                    self.shoppingCartViewModel.setOrderAsFinished(orderModel: currentOrder)
                                }
                            }
                        } label: {
                            Text("Aceptar")
                                .frame(maxWidth: .infinity)
                                .foregroundColor(Color("buttonTextColor"))
                                .font(.system(size: 16, weight: .bold, design: .rounded))
                                .padding(.vertical, 12)
                                .background{
                                    RoundedRectangle (cornerRadius: 30, style: .continuous)
                                        .fill(Color("blue"))
                                }
                                .padding(30)
                        }

                    }
                }
                .ignoresSafeArea()
            }
            
            if self.shoppingCartViewModel.showUserInfoError {
                VStack {
                    Rectangle()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .foregroundColor(Color("background"))
                        .opacity(0.8)
                }
                .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    Text("Error antes de procesar el pago ⚠️")
                        .font(.system(size: 18, weight: .black, design: .rounded))
                    
                    Text(self.shoppingCartViewModel.errorMessage)
                        .font(.system(size: 14, weight: .bold, design: .rounded))
                    
                    Spacer()
                    
                    Button {
                        self.shoppingCartViewModel.showUserInfoError = false
                        self.shoppingCartViewModel.isCheckoutButtonTapped = false
                    } label: {
                        Text("Aceptar")
                            .frame(maxWidth: .infinity)
                            .foregroundColor(Color("buttonTextColor"))
                            .font(.system(size: 16, weight: .bold, design: .rounded))
                            .padding(.vertical, 12)
                            .background{
                                RoundedRectangle (cornerRadius: 30, style: .continuous)
                                    .fill(Color("blue"))
                            }
                    }
                    .padding(.bottom, 5)
                        
                }
                .padding(10)
                .frame(height: 200)
                .background(Color("textField"))
                .cornerRadius(35)
                .shadow(color: Color("shadow"), radius: 4, x: 1, y: 2)
                .padding(.horizontal)
            }
            
        }
        .task {
            repeat {
                await self.shoppingCartViewModel.getUserOrders()
                
                self.shoppingCartViewModel.userDonutOrders.forEach { order in
                    if order.id == self.shoppingCartViewModel.currentOrderUUID {
                        self.shoppingCartViewModel.currentOrderStatus = order.status
                        print(order.status)
                    }
                }
                try? await Task.sleep(nanoseconds: 5_000_000_000)
            } while (!Task.isCancelled)
            print("task cancelled")
            
        }
    }
}

struct ShoppingCartView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingCartView()
    }
}
