//
//  OrdersHistoryCardView.swift
//  Happy Donuts
//
//  Created by Jacob Aguilar on 27-08-22.
//

import SwiftUI

struct OrdersHistoryCardView: View {
    
    @StateObject var shoppingCartViewModel = ShoppingCartViewModel()
    
    var body: some View {
        VStack {
            
            ForEach(self.shoppingCartViewModel.userDonutOrders) { order in
                ResumedOrderHistoryView(date: order.date, totalOrderPrice: order.finalPrice)
            }
            
            VStack {
                Button {
                    //
                } label: {
                    VStack {
                        Image(systemName: "list.bullet.circle.fill")
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
        .background(Color("background"))
        .cornerRadius(25)
        .shadow(color: Color("shadow"), radius: 2, x: 0, y: 1)
        .onAppear {
            Task {
                await self.shoppingCartViewModel.getUserOrders()
            }
        }
     
    }
}

struct OrdersHistoryCardView_Previews: PreviewProvider {
    static var previews: some View {
        OrdersHistoryCardView()
    }
}


struct ResumedOrderHistoryView: View {
    
    @State var date: String
    @State var totalOrderPrice: Int
    
    var body: some View {
        VStack {
            HStack {
                Text(date)
                
                Spacer()
                
                Text("Total: $\(totalOrderPrice)")
                
                Spacer()
                
                Button {
                    //
                } label: {
                    VStack {
                        Image(systemName: "plus")
                            .foregroundColor(Color("buttonTextColor"))
                            .padding(4)
                            .frame(width: 45, height: 45)
                    }
                    .frame(width: 30, height: 30)
                    .background(Color("green"))
                    .cornerRadius(10)
                    .shadow(color: Color("shadow"), radius: 0.5, x: 0, y: 0.5)
                }

            }
            
            Divider()
                .background(Color("fontColor"))
        }
    }
}
