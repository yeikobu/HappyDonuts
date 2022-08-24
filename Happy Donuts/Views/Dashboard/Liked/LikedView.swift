//
//  LikedView.swift
//  Happy Donuts
//
//  Created by Jacob Aguilar on 20-08-22.
//

import SwiftUI

struct LikedView: View {
    
    @StateObject var likedDonutViewModel: LikedDonutViewModel = LikedDonutViewModel()
    
    @State var likedDonutsQuantity: Int = 5
    @State var dismissedDonut: String = ""
    
    @Namespace var animation
    
    private let gridForm = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        VStack(alignment: .leading) {
            // MARK: - Banner/logo
            ZStack {
                Rectangle()
                    .frame(height: 140, alignment: .center)
                    .cornerRadius(35)
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
                                    .id(donut.name)
                            }
                        }
                        
                    }
                }
                .padding(.horizontal, 10)
            }
            .padding(.top, -5)
            
            Spacer()
        }
        .ignoresSafeArea()
        .background(Color("background"))
        .onAppear {
            self.likedDonutViewModel.getLikedDonuts()
        }
    }
}

struct LikedView_Previews: PreviewProvider {
    static var previews: some View {
        LikedView()
    }
}
