//
//  DonutCardView.swift
//  Happy Donuts
//
//  Created by Jacob Aguilar on 08-08-22.
//

import SwiftUI
import Kingfisher

struct DonutCardView: View {
    
    @State var donutModel: DonutModel
    var animation: Namespace.ID
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                Rectangle()
                    .foregroundColor(
                        self.donutModel.category == "glaseadas" ? Color("pink") :
                            self.donutModel.category == "chocolate" ? Color("green") :
                            self.donutModel.category == "normal" ? Color("blue") :
                            self.donutModel.category == "rellenas" ? Color("purple") :
                            Color("pink")
                    )
                    .frame(width: 170, height: 140, alignment: .center)
                    .cornerRadius(35)
                
                KFImage(URL(string: self.donutModel.imgUrl))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120, height: 113, alignment: .center)
            }
            .matchedGeometryEffect(id: "\(self.donutModel.name)backgroundColor", in: animation)
            
            VStack {
                VStack(alignment: .leading) {
                    Text(self.donutModel.name)
                        .font(.system(size: 14, weight: .black, design: .rounded))
                        .foregroundColor(Color("fontColor"))
                    
                    Text(self.donutModel.description)
                        .font(.system(size: 11, weight: .bold, design: .rounded))
                        .foregroundColor(Color("fontColor"))
                        .frame(height: 32)
                }
                .padding(.horizontal, 5)
                
                HStack(alignment: .center) {
                    
                    Spacer()
                    
                    Text("$\(donutModel.price)")
                        .font(.system(size: 14, weight: .black, design: .rounded))
                        .foregroundColor(Color("fontColor"))
                    
                    Spacer()
                }
            }
            .matchedGeometryEffect(id: "\(self.donutModel.name)info", in: animation)
            
            
            Spacer()
            
            
            
        }
        .background(Color("background"))
        .frame(width: 170, height: 250, alignment: .center)
        .cornerRadius(35)
        .shadow(color: Color("shadow"), radius: 2, x: 0, y: 1)
    }
}

struct DonutCardView_Previews: PreviewProvider {
    
    @Namespace static var animation
    
    static var previews: some View {
        DonutCardView(donutModel: DonutModel.init(), animation: animation)
    }
}
