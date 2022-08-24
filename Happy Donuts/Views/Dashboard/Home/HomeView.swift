//
//  HomeView.swift
//  Happy Donuts
//
//  Created by Jacob Aguilar on 01-08-22.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var homeViewModel: HomeViewModel = HomeViewModel()
    @ObservedObject var donutsViewModel: DonutsViewModel = DonutsViewModel()
    
    @State var searchDonut: String = ""
    @State var selectedCategory: String = "populares"
    @State var isDonutSelected: Bool = false
    @State var donutModel = DonutModel.init()
    @State var dismissedDonut: String = ""
    
    @Namespace var animation
    
    private let gridForm = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        VStack {
            if !isDonutSelected {
                VStack {
                    // MARK: - Banner/logo
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
                    // MARK: - End banner/logo
                    
                    // MARK: - Search space
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
                    // MARK: - End search space
                    
                    // MARK: - Categories Scroll View
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 0) {
                            ForEach(homeViewModel.categories, id: \.self) { category in
                                
                                if category != self.selectedCategory {
                                    Text(category.capitalizingFirstLetter())
                                        .font(.system(size: 16, weight: .bold, design: .rounded))
                                        .foregroundColor(Color("fontColor"))
                                        .padding(4)
                                        .padding(.horizontal, 4)
                                        .onTapGesture {
                                            withAnimation() {
                                                self.selectedCategory = category
                                            }
                                            
                                        }
                                } else {
                                    Text(category.capitalizingFirstLetter())
                                        .font(.system(size: 16, weight: .bold, design: .rounded))
                                        .foregroundColor(Color("buttonTextColor"))
                                        .padding(4)
                                        .padding(.horizontal, 4)
                                        .background(Color(
                                            category == "chocolate" ? "green" :
                                            category == "rellenas" ? "purple" :
                                            category == "normal" ? "blue" :
                                            "pink"
                                            )
                                        )
                                        .cornerRadius(30)
                                        .onTapGesture {
                                            withAnimation() {
                                                self.selectedCategory = category
                                            }
                                        }
                                        .matchedGeometryEffect(id: "selectedCategorie", in: animation)
                                }
                                
                            }
                        }
                        .background(Color("switchBackground"))
                        .cornerRadius(30)
                        .padding(.top, 10)
                        .padding(.horizontal, 10)
                    }
                    // MARK: - End Categories Scroll View
                }
                
                // MARK: - Donuts Scroll View
                VStack {
                    ScrollView(showsIndicators: false) {
                        ScrollViewReader { value in
                            Divider()
                                .opacity(0)
                                .onAppear {
                                    value.scrollTo(dismissedDonut) // This line is used in order to go to the seleted donut when the view appear again (It is necesary the view id)
                                }
                            
                            LazyVGrid(columns: self.gridForm) {
                                
                                if self.selectedCategory == self.homeViewModel.categories[0] {
                                    ForEach(self.donutsViewModel.donutsModel, id: \.self) { donut in
                                        DonutCardView(donutModel: donut, animation: animation)
//                                            .matchedGeometryEffect(id: "\(donut.name)", in: animation)
                                            .padding(.vertical, 2)
                                            .transition(.scale)
                                            .onTapGesture {
                                                self.donutsViewModel.setDataFromSelectedDonut(imgUrl: donut.imgUrl, name: donut.name, price: donut.price, description: donut.description, donutModel: donut)
                                                withAnimation(.spring(response: 0.7, dampingFraction: 0.80)) {
                                                    self.isDonutSelected = true
                                                }
                                            }
                                            .id(donut.name)
                                    }
                                }
                                
                                if self.selectedCategory == self.homeViewModel.categories[1] {
                                    ForEach(self.donutsViewModel.glaseadaDonuts, id: \.self) { donut in
                                        DonutCardView(donutModel: donut, animation: animation)
//                                            .matchedGeometryEffect(id: "\(donut.name)", in: animation)
                                            .padding(.vertical, 2)
                                            .transition(.scale)
                                            .onTapGesture {
                                                self.donutsViewModel.setDataFromSelectedDonut(imgUrl: donut.imgUrl, name: donut.name, price: donut.price, description: donut.description, donutModel: donut)
                                                withAnimation(.spring(response: 0.7, dampingFraction: 0.80)) {
                                                    self.isDonutSelected = true
                                                }
                                            }
                                            .id(donut.name)
                                    }
                                }
                                
                                if self.selectedCategory == self.homeViewModel.categories[2] {
                                    ForEach(self.donutsViewModel.chocolateDonuts, id: \.self) { donut in
                                        DonutCardView(donutModel: donut, animation: animation)
//                                            .matchedGeometryEffect(id: "\(donut.name)", in: animation)
                                            .padding(.vertical, 2)
                                            .transition(.scale)
                                            .onTapGesture {
                                                self.donutsViewModel.setDataFromSelectedDonut(imgUrl: donut.imgUrl, name: donut.name, price: donut.price, description: donut.description, donutModel: donut)
                                                withAnimation(.spring(response: 0.7, dampingFraction: 0.80)) {
                                                    self.isDonutSelected = true
                                                }
                                            }
                                            .id(donut.name)
                                    }
                                }
                                
                                if self.selectedCategory == self.homeViewModel.categories[3] {
                                    ForEach(self.donutsViewModel.rellenaDonuts, id: \.self) { donut in
                                        DonutCardView(donutModel: donut, animation: animation)
//                                            .matchedGeometryEffect(id: "\(donut.name)", in: animation)
                                            .padding(.vertical, 2)
                                            .transition(.scale)
                                            .onTapGesture {
                                                self.donutsViewModel.setDataFromSelectedDonut(imgUrl: donut.imgUrl, name: donut.name, price: donut.price, description: donut.description, donutModel: donut)
                                                withAnimation(.spring(response: 0.7, dampingFraction: 0.80)) {
                                                    self.isDonutSelected = true
                                                }
                                            }
                                            .id(donut.name)
                                    }
                                }
                                
                                if self.selectedCategory == self.homeViewModel.categories[4] {
                                    ForEach(self.donutsViewModel.normalDonuts, id: \.self) { donut in
                                        DonutCardView(donutModel: donut, animation: animation)
//                                            .matchedGeometryEffect(id: "\(donut.name)", in: animation)
                                            .padding(.vertical, 2)
                                            .transition(.scale)
                                            .onTapGesture {
                                                self.donutsViewModel.setDataFromSelectedDonut(imgUrl: donut.imgUrl, name: donut.name, price: donut.price, description: donut.description, donutModel: donut)
                                                withAnimation(.spring(response: 0.7, dampingFraction: 0.80)) {
                                                    self.isDonutSelected = true
                                                }
                                            }
                                            .id(donut.name)
                                    }
                                }
                                
                            }
                            .matchedGeometryEffect(id: "grid", in: animation)
                        }
                        
                    }
                    .padding(.horizontal, 15)
                    .padding(.bottom, 35)
                }
                // MARK: - End Donuts Scroll View
                
                Spacer()
            }
            
            if isDonutSelected {
                DonutView(donutModel: self.donutsViewModel.donutModel, animation: animation, imgUrl: self.$donutsViewModel.imgUrl, name: self.$donutsViewModel.name, price: self.$donutsViewModel.price, description: self.$donutsViewModel.description, isDonutSelected: self.$isDonutSelected, dismissedDonut: self.$dismissedDonut)
//                    .matchedGeometryEffect(id: "\(self.donutsViewModel.name)", in: animation)
            }
   
        }
        .ignoresSafeArea(edges: [.top])
        .background(Color("background"))
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
