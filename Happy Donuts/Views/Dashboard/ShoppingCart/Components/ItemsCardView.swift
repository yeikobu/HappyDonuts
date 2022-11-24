//
//  ItemsCardView.swift
//  Happy Donuts
//
//  Created by Jacob Aguilar on 23-11-22.
//

import SwiftUI
import Kingfisher

struct ItemsCardView: View {
    
    @State var cartItemModel: CartItemModel
    @EnvironmentObject var shoppingCartViewModel: ShoppingCartViewModel
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            HStack(spacing: 4) {
                ZStack {
                    Rectangle()
                        .foregroundColor(
                            self.cartItemModel.donut.category == "glaseadas" ? Color("pink") :
                                self.cartItemModel.donut.category == "chocolate" ? Color("green") :
                                self.cartItemModel.donut.category == "normal" ? Color("blue") :
                                self.cartItemModel.donut.category == "rellenas" ? Color("purple") :
                                Color("green")
                        )
                        .frame(width: 65, height: 65, alignment: .center)
                        .cornerRadius(15)
                    
                    KFImage(URL(string: self.cartItemModel.donut.imgUrl))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 45, alignment: .center)
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    Text(self.cartItemModel.donut.name)
                        .font(.system(size: 14, weight: .bold, design: .rounded))
                        .frame(height: 34)
                    
                    Text("$\(cartItemModel.donut.price)") //todo
                        .font(.system(size: 14, weight: .semibold, design: .rounded))
                }
                .frame(width: 120, height: 65, alignment: .leading)
                
                VStack(alignment: .trailing, spacing: 10) {
                    HStack {
                        //Minus Button
                        Button {
                            //updating the view
                            self.cartItemModel.quantity -= 1
                            if self.cartItemModel.quantity < 1 {
                                self.cartItemModel.quantity = 1
                            }
                            
                            //updating the viewModel array
                            if let item = self.shoppingCartViewModel.cartItems.firstIndex(where: {$0.id == self.cartItemModel.id}) {
                                self.shoppingCartViewModel.cartItems[item].quantity -= 1
                                if self.shoppingCartViewModel.cartItems[item].quantity < 1 {
                                    self.shoppingCartViewModel.cartItems[item].quantity = 1
                                }
                                self.shoppingCartViewModel.cartItems[item].quantityPrice = self.cartItemModel.donut.price * self.shoppingCartViewModel.cartItems[item].quantity
                            }
                            
                            self.shoppingCartViewModel.sumTotalPrice()
                        } label: {
                            VStack {
                                Image(systemName: "minus")
                                    .font(.system(size: 14, weight: .black, design: .rounded))
                                    .foregroundColor(Color("buttonTextColor"))
                                    .padding(4)
                                    .frame(width: 25, height: 25)
                            }
                            .background(
                                self.cartItemModel.donut.category == "glaseadas" ? Color("pink") :
                                    self.cartItemModel.donut.category == "chocolate" ? Color("green") :
                                    self.cartItemModel.donut.category == "normal" ? Color("blue") :
                                    self.cartItemModel.donut.category == "rellenas" ? Color("purple") :
                                    Color("green")
                            )
                            .cornerRadius(8)
                            .shadow(color: Color("shadow"), radius: 1, x: 0, y: 1)
                        }
                        
                        Text("\(self.cartItemModel.quantity)")
                            .font(.system(size: 14, weight: .bold, design: .rounded))
                            .foregroundColor(Color("fontColor"))
                            .padding(.leading, 5)
                            .background(
                                RoundedRectangle(cornerRadius: 8, style: .continuous)
                                    .foregroundColor(Color("textField"))
                                    .shadow(color: Color("shadow"), radius: 0.5, x: 0, y: 1)
                                    .frame(width: 40,height: 25, alignment: .leading)
                            )
                            .frame(width: 30)
                        
                        
                        //Plus Button
                        Button {
                            //updatig the view
                            self.cartItemModel.quantity += 1
                            if self.cartItemModel.quantity > 20 {
                                self.cartItemModel.quantity = 20
                            }
                            
                            //updating the viewModel array
                            if let item = self.shoppingCartViewModel.cartItems.firstIndex(where: {$0.id == self.cartItemModel.id}) {
                                self.shoppingCartViewModel.cartItems[item].quantity += 1
                                if self.shoppingCartViewModel.cartItems[item].quantity > 20 {
                                    self.shoppingCartViewModel.cartItems[item].quantity = 20
                                }
                                self.shoppingCartViewModel.cartItems[item].quantityPrice = self.cartItemModel.donut.price * self.shoppingCartViewModel.cartItems[item].quantity
                            }
                            
                            self.shoppingCartViewModel.sumTotalPrice()
                        } label: {
                            VStack {
                                Image(systemName: "plus")
                                    .font(.system(size: 14, weight: .black, design: .rounded))
                                    .foregroundColor(Color("buttonTextColor"))
                                    .padding(4)
                                    .frame(width: 25, height: 25)
                            }
                            .background(
                                self.cartItemModel.donut.category == "glaseadas" ? Color("pink") :
                                    self.cartItemModel.donut.category == "chocolate" ? Color("green") :
                                    self.cartItemModel.donut.category == "normal" ? Color("blue") :
                                    self.cartItemModel.donut.category == "rellenas" ? Color("purple") :
                                    Color("green")
                            )
                            .cornerRadius(8)
                            .shadow(color: Color("shadow"), radius: 1, x: 0, y: 1)
                        }
                        
                        
                    }
                    .padding(.bottom, 8)
                    
                    Text("$\(self.cartItemModel.donut.price * self.cartItemModel.quantity)")
                        .font(.system(size: 14, weight: .black, design: .rounded))
                        .padding(.trailing, 10)
                }
                .padding(.trailing, 10)
                
                
            }
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(Color("background"))
                    .cornerRadius(15)
                    .shadow(color: Color("shadow"), radius: 2, x: 0, y: 1)
            )
            .frame(height: 65)
            .foregroundColor(Color("fontColor"))
            .padding(.trailing, 5)
            
            
            Button {
                withAnimation(.easeIn) {
                    self.shoppingCartViewModel.removeFromCart(id: self.cartItemModel.id)
                    self.shoppingCartViewModel.sumTotalPrice()
                }
            } label: {
                VStack {
                    Image(systemName: "trash.fill")
                        .font(.system(size: 10, weight: .black, design: .rounded))
                        .foregroundColor(Color("buttonTextColor"))
                        .padding(4)
                        .frame(width: 20, height: 20)
                }
                .background(Color(.red))
                .cornerRadius(8)
                .shadow(color: Color("shadow"), radius: 1, x: 0, y: 1)
            }
            
            
        }
    }
}

struct ItemsCardView_Previews: PreviewProvider {
    static var previews: some View {
        ItemsCardView(cartItemModel: CartItemModel.init(donut: DonutModel(), quantity: 2, quantityPrice: 1200))
    }
}
