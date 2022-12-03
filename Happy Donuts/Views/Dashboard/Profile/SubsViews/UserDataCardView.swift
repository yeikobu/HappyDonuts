//
//  UserDataCardView.swift
//  Happy Donuts
//
//  Created by Jacob Aguilar on 27-08-22.
//

import SwiftUI

struct UserDataCardView: View {
    
    @StateObject var profileViewModel = ProfileViewModel()
    @StateObject var locationViewModel = LocationViewModel()
    
    var body: some View {
        VStack {
            VStack(spacing: 10) {
                HStack {
                    Text("Nombre: ")
                    
                    if !self.profileViewModel.isEditPressed {
                        Spacer()
                        Text("\(self.profileViewModel.userExtraDataModel.name == "" ? "Ingresa tu nombre y apellido" : self.profileViewModel.userExtraDataModel.name)")
                    } else {
                        ZStack(alignment: .leading) {
                            if (self.profileViewModel.userExtraDataModel.name.isEmpty) {
                                Text(verbatim: "Ingresa tu nombre y apellido")
                                    .font(.system(size: 14, weight: .bold, design: .rounded))
                                    .padding(.leading, 5)
                            }
                            
                            TextField(" ", text: self.$profileViewModel.userExtraDataModel.name)
                                .font(.system(size: 14, weight: .bold, design: .rounded))
                                .keyboardType(.default)
                                .ignoresSafeArea(.keyboard, edges: .bottom)
                                .padding(5)
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .foregroundColor(Color("switchBackground"))
                                .shadow(color: Color("shadow"), radius: 1, x: 1, y: 2)
                        )
                        .padding(.horizontal, 10)
                    }
                }
                
                HStack {
                    Text("Correo: ")
                    Spacer()
                    
                    if let userEmail = self.profileViewModel.userModel?.userEmail {
                        Text(verbatim: String(userEmail))
                    }
                }
                
                HStack {
                    Text("Teléfono: ")
                    
                    if !self.profileViewModel.isEditPressed {
                        Spacer()
                        Text("\(self.profileViewModel.userExtraDataModel.phone == "" ? "Ingresa tu número de teléfono" : self.profileViewModel.userExtraDataModel.phone)")
                    } else {
                        ZStack(alignment: .leading) {
                            if (self.profileViewModel.userExtraDataModel.phone.isEmpty) {
                                Text(verbatim: "Ingresa tu número de teléfono")
                                    .font(.system(size: 14, weight: .bold, design: .rounded))
                                    .padding(.leading, 5)
                            }
                            
                            TextField(" ", text: self.$profileViewModel.userExtraDataModel.phone)
                                .font(.system(size: 14, weight: .bold, design: .rounded))
                                .keyboardType(.default)
                                .ignoresSafeArea(.keyboard, edges: .bottom)
                                .padding(5)
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .foregroundColor(Color("switchBackground"))
                                .shadow(color: Color("shadow"), radius: 1, x: 1, y: 2)
                        )
                        .padding(.horizontal, 10)
                    }
                }
                
                HStack {
                    Text("Domicilio")
                    
                    if !self.profileViewModel.isEditPressed {
                        Spacer()
                        Text("\(self.profileViewModel.userExtraDataModel.location == "" ? "Ingresa tu dirección" : self.profileViewModel.userExtraDataModel.location)")
                    } else {
                        ZStack(alignment: .leading) {
                            if (self.profileViewModel.userExtraDataModel.location.isEmpty) {
                                Text(verbatim: "Ingresa tu dirección")
                                    .font(.system(size: 14, weight: .bold, design: .rounded))
                                    .padding(.leading, 5)
                            }
                            
                            TextField(" ", text: self.$profileViewModel.userExtraDataModel.location)
                                .font(.system(size: 14, weight: .bold, design: .rounded))
                                .keyboardType(.default)
                                .ignoresSafeArea(.keyboard, edges: .bottom)
                                .padding(5)
                                .onTapGesture {
                                    self.profileViewModel.isLocationTapped = true
                                }
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .foregroundColor(Color("switchBackground"))
                                .shadow(color: Color("shadow"), radius: 1, x: 1, y: 2)
                        )
                        .padding(.horizontal, 10)
                        .sheet(isPresented: self.$profileViewModel.isLocationTapped) {
                            LocationView()
                                .ignoresSafeArea()
                                .environmentObject(locationViewModel)
                                .onDisappear {
                                    self.profileViewModel.userExtraDataModel.location = self.locationViewModel.selectedLocation
                                }
                        }
                    }
                   
                }
                
                VStack {
                    Button {
                        withAnimation(.easeIn) {
                            self.profileViewModel.isEditPressed.toggle()
                        }
                        self.profileViewModel.setUserExtraData(userExtraData: self.profileViewModel.userExtraDataModel)
                    } label: {
                        VStack {
                            Image(systemName: self.profileViewModel.isEditPressed ? "checkmark.circle.fill" : "pencil")
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
