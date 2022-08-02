//
//  HomeView.swift
//  Happy Donuts
//
//  Created by Jacob Aguilar on 01-08-22.
//

import SwiftUI

struct HomeView: View {
    
    @State var searchDonut: String = ""
    
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .frame(height: 140, alignment: .center)
                    .cornerRadius(35)
                    .foregroundColor(Color("pink"))
                    
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 123, height: 76, alignment: .center)
                    .padding(.top, 30)
            }
            
            VStack(alignment: .leading) {
                
                Text("¿Qué deseas pedir hoy?")
                    .font(.system(size: 24, weight: .black, design: .rounded))
                    .foregroundColor(Color("fontColor"))
                    .frame(alignment: .leading)
                
                HStack {
                    VStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(Color("fontColor"))
                            .font(.system(size: 16))
                    }
                    .frame(width: 30, height: 42, alignment: .center)
                    .padding(.leading, 10)
                    
                    ZStack(alignment: .leading) {
                        if self.searchDonut.isEmpty {
                            Text(verbatim: "Busca alguna donut...")
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                .foregroundColor(Color("fontColor"))
                        }
                        
                        TextField("", text: self.$searchDonut)
                            .foregroundColor(Color("fontColor"))
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .keyboardType(.default)
                            .ignoresSafeArea(.keyboard, edges: .bottom)
                            .padding(.vertical, 10)
                    }
                }
                .background(
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .foregroundColor(Color("textField"))
                        .shadow(color: Color("shadow"), radius: 2, x: 0, y: 1)
                )
                .padding(.top, -10)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 10)
            .padding(.horizontal, 10)
            
            
            Spacer()
        }
        .ignoresSafeArea(.all, edges: .top)
        .background(Color("background"))
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
