//
//  DashboardView.swift
//  Happy Donuts
//
//  Created by Jacob Aguilar on 29-07-22.
//

import SwiftUI

let tabs = ["person.fill", "bag.fill", "heart.fill", "cart.fill"]
let tabColors = ["green", "pink", "purple", "blue"]

struct DashboardView: View {
    
    @State var backToLogin = false
    @State var selectedTab = "bag.fill"
    
    var body: some View {
        
        ZStack {
            CustomTabView()
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
            
        }
        .ignoresSafeArea()
        .background(Color("background"))

    }
    
}

struct TabButtonview: View {
    
    @Binding var selectedTab: String
    var imageName: String
    
    var body: some View {
        Button {
            selectedTab = imageName
            
        } label: {
            VStack {
                Image(systemName: imageName)
                    .foregroundColor(
                        selectedTab == imageName && selectedTab == tabs[0] ? Color(tabColors[0]) :
                        selectedTab == imageName && selectedTab == tabs[1] ? Color(tabColors[1]) :
                        selectedTab == imageName && selectedTab == tabs[2] ? Color(tabColors[2]) :
                        selectedTab == imageName && selectedTab == tabs[3] ? Color(tabColors[3]) :
                        Color(.gray)
                    )
                    .font(.system(size: 32, weight: .bold))
                    .padding(.bottom, 10)
            }
        }
        
    }
}


struct CustomTabView: View {
    
    @State var selectedTab: String = "bag.fill"
    @State var edge: CGFloat = 0.0
    
    var body: some View {
        
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
            
            TabView(selection: $selectedTab) {
                
                Text("Profile")
                    .tag("person.fill")
                
                HomeView()
                    .tag("bag.fill")
                
                Text("Liked")
                    .tag("heart.fill")
                
                Text("Cart")
                    .tag("cart.fill")
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .ignoresSafeArea(.all, edges: .bottom)
            
            HStack(spacing: 0) {
                
                ForEach(tabs, id: \.self) { imageName in
                    TabButtonview(selectedTab: $selectedTab, imageName: imageName)
                    if imageName != tabs.last {
                        Spacer(minLength: 0)
                    }
                }
                
            }
            .padding(.horizontal, 34)
            .padding(.vertical, 16)
            .background(
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .foregroundColor(Color("background"))
                    .shadow(color: Color("shadow"), radius: 2, x: 2, y: -2)
                    .shadow(color: Color("shadow"), radius: -1, x: -2, y: 2)
            )
            
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
        
        
        
        
    }
    
}


struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}

