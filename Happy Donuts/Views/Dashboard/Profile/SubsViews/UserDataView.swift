//
//  UserDataView.swift
//  Happy Donuts
//
//  Created by Jacob Aguilar on 03-09-22.
//

import SwiftUI

struct UserDataView: View {
    
//    @StateObject var profileViewModel: ProfileViewModel = ProfileViewModel()
    @State var name = "Jacob Aguilar"
    @State var isEditNamePressed = false
    
    @FocusState private var nameFocus: Bool
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 10) {
                VStack(alignment: .leading, spacing: 1) {
                    Text("Nombre: ")
                    HStack {
                        ZStack(alignment: .leading) {
                            HStack {
                                TextField(" ", text: self.$name)
                                    .disabled(!self.isEditNamePressed)
                                    .focused($nameFocus)
                                    .keyboardType(.default)
                                    .ignoresSafeArea(.keyboard, edges: .bottom)
                                    .padding(.vertical, 10)
                                    .padding(.leading, 4)
                                
                                Image(systemName: "x.circle.fill")
                                    .padding(.trailing, 4)
                                    .font(.system(size: 18, weight: .bold, design: .rounded))
                                    .foregroundColor(Color("fontColor"))
                                    .onTapGesture {
                                        
                                    }
                            }
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 15, style: .continuous)
                                .foregroundColor(Color("textField"))
                                .shadow(color: Color("shadow"), radius: 2, x: 0, y: 1)
                        )
                        
                        Image(systemName: "pencil.circle.fill")
                            .foregroundColor(Color("green"))
                            .font(.system(size: 22, weight: .bold, design: .rounded))
                            .onTapGesture {
                                self.isEditNamePressed = true
                                self.nameFocus = true
                            }
                    }
                        
                }
            }
            .font(.system(size: 14, weight: .bold, design: .rounded))
            .foregroundColor(Color("fontColor"))
            .padding()
        }
        .background(Color("background"))
        .cornerRadius(35)
        .shadow(color: Color("shadow"), radius: 2, x: 0, y: 1)
        
    }
}

struct UserDataView_Previews: PreviewProvider {
    static var previews: some View {
        UserDataView()
    }
}
