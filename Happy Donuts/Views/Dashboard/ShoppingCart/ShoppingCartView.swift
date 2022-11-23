//
//  ShoppingCartView.swift
//  Happy Donuts
//
//  Created by Jacob Aguilar on 21-11-22.
//

import SwiftUI

struct ShoppingCartView: View {
    
    @EnvironmentObject var shoppingCartViewModel: ShoppingCartViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
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
            
            VStack {
                Text("Confirma tu pedido")
                    .font(.system(size: 24, weight: .black, design: .rounded))
                    .foregroundColor(Color("fontColor"))
            }
            .frame(alignment: .leading)
            .padding(.horizontal, 15)
            .padding(.top, -20)
            
//            Spacer()
            
            if shoppingCartViewModel.cartItems.count > 0 {
                ScrollView(showsIndicators: true) {
                    ForEach(shoppingCartViewModel.cartItems) { item in
                        HStack {
                            Spacer()
                            ItemsCardView(cartItemModel: item)
                                .padding(.top, 5)
                            Spacer() 
                        }
                    }
                }
                .frame(maxHeight: 300)
            } else {
                Spacer()
                HStack {
                    Spacer()
                    Text("Tu carrito de compras está vacío...")
                    Spacer()
                }
                .frame(alignment: .center)
            }
            
            Spacer()
            Spacer()
            Spacer()
        }
    }
}

struct ShoppingCartView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingCartView()
            .environmentObject(ShoppingCartViewModel())
    }
}
