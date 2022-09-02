//
//  ProfileView.swift
//  Happy Donuts
//
//  Created by Jacob Aguilar on 27-08-22.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack(alignment: .leading) {
            
            ZStack {
                Rectangle()
                    .frame(height: 140, alignment: .center)
                    .cornerRadius(35, corners: [.bottomLeft, .bottomRight])
                    .foregroundColor(Color("green"))
                    
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 123, height: 76, alignment: .center)
                    .padding(.top, 30)
            }
            
            VStack(alignment: .leading) {
                Text("Perfil de usuario")
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .foregroundColor(Color("fontColor"))
                    .padding(.bottom, 20)
                
                Text("Datos de contacto")
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .foregroundColor(Color("fontColor"))
                    .padding(.bottom, -5)
                
                UserDataCardView()
                
                Text("Historial de Pedidos")
                    .padding(.top, 20)
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .foregroundColor(Color("fontColor"))
                    .padding(.bottom, -5)
                OrdersHistoryCardView()
            }
            .padding(.horizontal, 10)
            
            
            Spacer()
        }
        .ignoresSafeArea()
        .background(Color("background"))
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
