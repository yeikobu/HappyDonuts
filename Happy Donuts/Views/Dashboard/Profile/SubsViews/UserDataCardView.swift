//
//  UserDataCardView.swift
//  Happy Donuts
//
//  Created by Jacob Aguilar on 27-08-22.
//

import SwiftUI

struct UserDataCardView: View {
    
    @StateObject var profileViewModel = ProfileViewModel()
    
    var body: some View {
        VStack {
            VStack(spacing: 10) {
                HStack {
                    Text("Nombre: ")
                    Spacer()
                    Text("\(self.profileViewModel.userExtraDataModel.userName)")
                }
                
                HStack {
                    Text("Correo: ")
                    Spacer()
                    Text(verbatim: String(describing: self.profileViewModel.userModel!.userEmail))
                }
                
                HStack {
                    Text("Teléfono: ")
                    Spacer()
                    Text("\(self.profileViewModel.userExtraDataModel.userPhoneNumber)")
                }
                
                HStack {
                    Text("Domicilio")
                    Spacer()
                    Text("\(self.profileViewModel.userExtraDataModel.direction)")
                }
                
                VStack {
                    Button {
                        //
                    } label: {
                        VStack {
                            Image(systemName: "pencil")
                                .font(.system(size: 28, weight: .black, design: .rounded))
                                .foregroundColor(Color("buttonTextColor"))
                                .padding(4)
                                .frame(width: 45, height: 45)
                        }
                        .background(Color("green"))
                        .cornerRadius(15)
                        .shadow(color: Color("shadow"), radius: 1, x: 0, y: 1)
                    }

                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .font(.system(size: 14, weight: .bold, design: .rounded))
            .foregroundColor(Color("fontColor"))
            .padding()
        }
        .background(Color("background"))
        .cornerRadius(35)
        .shadow(color: Color("shadow"), radius: 2, x: 0, y: 1)
        .task {
            await self.profileViewModel.getUserExtraData()
        }
    }
}

struct UserDataCardView_Previews: PreviewProvider {
    static var previews: some View {
        UserDataCardView()
    }
}
