//
//  LikedView.swift
//  Happy Donuts
//
//  Created by Jacob Aguilar on 20-08-22.
//

import SwiftUI

struct LikedView: View {
    
    @State var likedDonutsQuantity: Int = 5
    
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
            
            Text("\(self.likedDonutsQuantity) Happy donuts favoritas")
                .font(.system(size: 24, weight: .bold, design: .rounded))
                .foregroundColor(Color("fontColor"))
                .padding(.leading, 10)
            
            Spacer()
        }
        .ignoresSafeArea()
        .background(Color("background"))
    }
}

struct LikedView_Previews: PreviewProvider {
    static var previews: some View {
        LikedView()
    }
}
