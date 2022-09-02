//
//  LikedView.swift
//  Happy Donuts
//
//  Created by Jacob Aguilar on 20-08-22.
//

import SwiftUI

struct LikedView: View {
    
    @StateObject var likedDonutViewModel: LikedDonutViewModel = LikedDonutViewModel()
    @ObservedObject var donutsViewModel: DonutsViewModel = DonutsViewModel()
    
    @State var donutModel = DonutModel.init()
    
    @State var likedDonutsQuantity: Int = 5
    @State var dismissedDonut: String = ""
    @State var searchDonut: String = ""
    @State var selectedCategory: String = "populares"
    @State var isDonutSelected: Bool = false
    
    @Namespace var animation
    
    private let gridForm = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
//        VStack {
//            if !isDonutSelected {
                VStack(alignment: .leading) {
                    if !isDonutSelected {
                    // MARK: - Banner/logo
                        ZStack {
                            Rectangle()
                                .frame(height: 140, alignment: .center)
                                .cornerRadius(35, corners: [.bottomLeft, .bottomRight])
                                .foregroundColor(Color("purple"))
                                
                            Image("logo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 123, height: 76, alignment: .center)
                                .padding(.top, 30)
                        }
                        // MARK: - End banner/logo
                        
                        Text(self.likedDonutViewModel.likedDonutsQuantity == 1 ? "\(self.likedDonutViewModel.likedDonutsQuantity) Happy donut favorita" : "\(self.likedDonutViewModel.likedDonutsQuantity) Happy donuts favoritas")
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                            .foregroundColor(Color("fontColor"))
                            .padding(.leading, 10)
                        
                        VStack {
                            ScrollView(showsIndicators: false) {
                                ScrollViewReader { value in
                                    Divider()
                                        .opacity(0)
                                        .onAppear {
                                            value.scrollTo(dismissedDonut) // This line is used in order to go to the seleted donut when the view appear again (It is necesary the view id)
                                        }
                                    
                                    LazyVGrid(columns: self.gridForm) {
                                        ForEach(self.likedDonutViewModel.likedDonuts, id: \.self) { donut in
                                            DonutCardView(donutModel: donut, animation: animation)
                                                .onTapGesture {
                                                    self.donutsViewModel.setDataFromSelectedDonut(imgUrl: donut.imgUrl, name: donut.name, price: donut.price, description: donut.description, donutModel: donut, category: donut.category, sellCount: donut.sellCount)
                                                    withAnimation(.spring(response: 0.7, dampingFraction: 0.80)) {
                                                        self.isDonutSelected = true
                                                    }
                                                }
                                                .id(donut.name)
                                                
                                        }
                                    }
                                    
                                }
                            }
                            .padding(.horizontal, 10)
                        }
                        .padding(.top, -5)
                    }
                    
                    if isDonutSelected {
                        DonutView(donutModel: self.donutsViewModel.donutModel, animation: animation, imgUrl: self.$donutsViewModel.imgUrl, name: self.$donutsViewModel.name, price: self.$donutsViewModel.price, description: self.$donutsViewModel.description, isDonutSelected: self.$isDonutSelected, dismissedDonut: self.$dismissedDonut, category: self.$donutsViewModel.category, sellCount: self.$donutsViewModel.sellCount)
                    }
                }
                .ignoresSafeArea(edges: .top)
                .background(Color("background"))
                .onAppear {
                    self.likedDonutViewModel.getLikedDonuts()
                }
                
//            }
            
//            if isDonutSelected {
//                DonutView(donutModel: self.donutsViewModel.donutModel, animation: animation, imgUrl: self.$donutsViewModel.imgUrl, name: self.$donutsViewModel.name, price: self.$donutsViewModel.price, description: self.$donutsViewModel.description, isDonutSelected: self.$isDonutSelected, dismissedDonut: self.$dismissedDonut, category: self.$donutsViewModel.category, sellCount: self.$donutsViewModel.sellCount)
//            }
//        }
        
        
    }
}

struct LikedView_Previews: PreviewProvider {
    static var previews: some View {
        LikedView()
    }
}
