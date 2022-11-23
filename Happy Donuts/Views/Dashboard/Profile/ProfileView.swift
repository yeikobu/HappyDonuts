//
//  ProfileView.swift
//  Happy Donuts
//
//  Created by Jacob Aguilar on 27-08-22.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject var profileViewModel = ProfileViewModel()
    
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
            }
            .padding(.horizontal, 10)
            
            ScrollView(showsIndicators: false) {
                
                VStack(alignment: .leading) {
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
                
                VStack {
                    Button {
                        self.profileViewModel.logout()
                        self.profileViewModel.isLogoutPressed = true
                    } label: {
                        VStack {
                            Text("Cerrar Sesión")
                                .foregroundColor(Color("buttonTextColor"))
                                .font(.system(size: 30, weight: .bold, design: .rounded))
                                .padding(.horizontal, 50)
                        }
                        .padding(12)
                        .background(Color("green"))
                        .cornerRadius(40)
                        .shadow(color: .gray, radius: 2, x: 0, y: 1)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
            }

            
            Spacer()
            
            NavigationLink(isActive: self.$profileViewModel.isLogoutPressed) {
                LoginView()
            } label: {
                EmptyView()
            }
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
