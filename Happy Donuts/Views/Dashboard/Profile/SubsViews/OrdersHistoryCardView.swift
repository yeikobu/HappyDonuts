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
            if self.shoppingCartViewModel.userDonutOrders.count == 0 {
                Text("No has realizado pedidos aún...")
                    .font(.system(size: 16, weight: .black, design: .rounded))
            } else {
                ForEach(self.shoppingCartViewModel.userDonutOrders) { order in
                    ResumedOrderHistoryView(date: order.date, totalOrderPrice: order.finalPrice, userOrder: order.cartItems)
                }
            }
            
            VStack {
//                Button {
//                    //
//                } label: {
//                    VStack {
//                        Image(systemName: "list.bullet.circle.fill")
//                            .font(.system(size: 28, weight: .black, design: .rounded))
//                            .foregroundColor(Color("buttonTextColor"))
//                            .padding(4)
//                            .frame(width: 45, height: 45)
//                    }
//                    .background(Color("green"))
//                    .cornerRadius(15)
//                    .shadow(color: Color("shadow"), radius: 1, x: 0, y: 1)
//                }
//
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
    @State var showMoreInfo = false
    @Namespace var animation
    @State var userOrder: [CartItemModel]
    
    var body: some View {
        VStack {
            HStack {
                Text(date)
                
                Spacer()
                
                Text("Total: $\(totalOrderPrice)")
                    .matchedGeometryEffect(id: "totalPrice", in: animation)
                
                Spacer()
                
                Button {
                    withAnimation(.spring(response: 0.5, dampingFraction: 1)) {
                        self.showMoreInfo.toggle()
                    }
                } label: {
                    VStack {
                        Image(systemName: self.showMoreInfo ? "minus" : "plus")
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
            
            if self.showMoreInfo {
                ShowMoreInfoView(userOrder: self.$userOrder, date: self.$date, totalOrderPrice: self.$totalOrderPrice, animation: animation)
            }
            
            Divider()
                .background(Color("fontColor"))
        }
    }
}


struct ShowMoreInfoView: View {
    @Binding var userOrder: [CartItemModel]
    @Binding var date: String
    @Binding var totalOrderPrice: Int
    var animation: Namespace.ID
    
    var body: some View {
        VStack(spacing: 5) {
            ForEach(userOrder) { order in
                HStack {
                    Text(order.donut.name)
                        .frame(width: 155, alignment: .leading)
                    
                    Spacer()
                    
                    Text("x\(order.quantity)")
                    
                    Spacer()
                    
                    Text("$\(order.quantityPrice)")
                }
            }
            
            VStack {
                Text("Total: $\(totalOrderPrice)")
                    .matchedGeometryEffect(id: "totalPrice", in: animation)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.top, 10)
            }
        }
    }
}
