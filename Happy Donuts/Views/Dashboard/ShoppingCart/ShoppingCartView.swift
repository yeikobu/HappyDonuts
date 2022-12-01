//
//  ShoppingCartView.swift
//  Happy Donuts
//
//  Created by Jacob Aguilar on 21-11-22.
//

import SwiftUI

struct ShoppingCartView: View {
    
    @EnvironmentObject var shoppingCartViewModel: ShoppingCartViewModel
    @StateObject var locationViewModel = LocationViewModel()
    @State private var isDelivery = false
    @State private var isDeliveryToCurrentLocation = false
    @State private var isMapSHowing = false
    @Namespace var animation
    
    var body: some View {
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
                                    
                                    Text("Digüeñes 5083, Renca")
                                        .font(.system(size: 16, weight: .semibold, design: .rounded))
                                    
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
                        
                        HStack {
                            Text("Procesar pago")
                                .font(.system(size: 16, weight: .semibold, design: .rounded))
                            
                            Button {
                                //
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
    }
}

struct ShoppingCartView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingCartView()
            .environmentObject(ShoppingCartViewModel())
    }
}
