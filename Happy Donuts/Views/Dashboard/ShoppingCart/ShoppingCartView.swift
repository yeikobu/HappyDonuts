//
//  ShoppingCartView.swift
//  Happy Donuts
//
//  Created by Jacob Aguilar on 21-11-22.
//

import SwiftUI

struct ShoppingCartView: View {
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
                Text("Confirma tu pedido")
                    .font(.system(size: 24, weight: .black, design: .rounded))
                    .foregroundColor(Color("fontColor"))
                    .frame(alignment: .leading)
                
                ScrollView(showsIndicators: false) {
                    
                }
                
                Spacer()
            }
            .padding(.horizontal, 15)
            
            Spacer()
        }
    }
}

struct ShoppingCartView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingCartView()
    }
}
