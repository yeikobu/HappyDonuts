//
//  DonutCardView.swift
//  Happy Donuts
//
//  Created by Jacob Aguilar on 08-08-22.
//

import SwiftUI
import Kingfisher

struct DonutCardView: View {
    
    @ObservedObject private var donutsViewModel = DonutsViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                Rectangle()
                    .foregroundColor(Color("pink"))
                    .frame(width: 170, height: 140, alignment: .center)
                    .cornerRadius(35)
                
                KFImage(URL(string: self.donutsViewModel.imgUrl))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120, height: 113, alignment: .center)
            }
            
            VStack(alignment: .leading) {
                Text(self.donutsViewModel.name)
                    .font(.system(size: 14, weight: .black, design: .rounded))
                    .foregroundColor(Color("fontColor"))
                
                Text(self.donutsViewModel.description)
                    .font(.system(size: 11, weight: .bold, design: .rounded))
                    .foregroundColor(Color("fontColor"))
                    .frame(height: 32)
            }
            .padding(.horizontal, 5)
            
            HStack(alignment: .center) {
                
                Spacer()
                
                Text("$\(donutsViewModel.price)")
                    .font(.system(size: 14, weight: .black, design: .rounded))
                
                Spacer()
            }
            
            Spacer()
            
            
            
        }
        .background(Color("background"))
        .frame(width: 170, height: 250, alignment: .center)
        .cornerRadius(35)
        .shadow(color: Color("shadow"), radius: 2, x: 0, y: 1)
    }
}

struct DonutCardView_Previews: PreviewProvider {
    static var previews: some View {
        DonutCardView()
        DonutCardView()
            .colorScheme(.dark)
    }
}
