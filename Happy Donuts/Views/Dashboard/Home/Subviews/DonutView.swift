//
//  DonutView.swift
//  Happy Donuts
//
//  Created by Jacob Aguilar on 11-08-22.
//

import SwiftUI
import Kingfisher

struct DonutView: View {
    
    @StateObject var hapticsEngine: Haptics = Haptics()
    @StateObject var likedDonutViewModel: LikedDonutViewModel = LikedDonutViewModel()
    @EnvironmentObject var shoppingCartViewModel: ShoppingCartViewModel
    
    @State var donutModel: DonutModel
    @State var isDonutInfoShowing: Bool = false
    @State var isLikedButtonAnimated: Bool = false
    @State var isDonutLiked: Bool = false
    @State var quantity: Int = 1
    @State var totalQuantity: Int = 0
    
    let animation: Namespace.ID
    let buttonAnimationDuration:  Double = 0.15
    var likedButtonAnimationScale: CGFloat {
        isLikedButtonAnimated ? 1.5 : 0.8
    }
    
    @Binding var imgUrl: String
    @Binding var name: String
    @Binding var price: Int
    @Binding var description: String
    @Binding var isDonutSelected: Bool
    @Binding var dismissedDonut: String
    @Binding var category: String
    @Binding var sellCount: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                Rectangle()
                    .foregroundColor(
                        self.donutModel.category == "glaseadas" ? Color("pink") :
                            self.donutModel.category == "chocolate" ? Color("green") :
                            self.donutModel.category == "normal" ? Color("blue") :
                            self.donutModel.category == "rellenas" ? Color("purple") :
                            Color("green")
                    )
                    .frame(maxWidth: .infinity, maxHeight: 270, alignment: .center)
                    .cornerRadius(35)
                
                KFImage(URL(string: self.imgUrl))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200, alignment: .center)
                    .padding(.top, 30)
                
                ZStack(alignment: .topTrailing) {
                    VStack {
                        Image(systemName: "xmark")
                            .font(.system(size: 20, weight: .black, design: .rounded))
                            .foregroundColor(Color("buttonTextColor"))
                            .padding(5)
                            .background(
                                self.donutModel.category == "glaseadas" ? Color("pink") :
                                    self.donutModel.category == "chocolate" ? Color("green") :
                                    self.donutModel.category == "normal" ? Color("blue") :
                                    self.donutModel.category == "rellenas" ? Color("purple") :
                                    Color("green")
                            )
                            .cornerRadius(30)
                            .shadow(color: Color("shadow"), radius: 1, x: 1, y: 1)
                            .onTapGesture {
                                self.dismissedDonut = self.name
                                
                                withAnimation(.spring(response: 0.7, dampingFraction: 1)) {
                                    self.isDonutInfoShowing = false
                                }
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                                    withAnimation(.spring(response: 0.2, dampingFraction: 1)) {
                                        self.isDonutSelected = false
                                    }
                                }
                            }
                    }
                    .padding(.top, 35)
                    .padding(.trailing, 10)
                }
                .frame(maxWidth: .infinity, maxHeight: 270, alignment: .topTrailing)
            }
            .matchedGeometryEffect(id: "\(self.donutModel.name)backgroundColor", in: animation)
            
            ScrollView {
                VStack(alignment: .leading) {
                    HStack {
                        Text(self.name)
                            .font(.system(size: 28, weight: .black, design: .rounded))
                            .foregroundColor(Color("fontColor"))
                        
                        Spacer()
                        
                        Image(systemName: self.isDonutLiked ? "heart.fill" : "heart")
                            .font(.system(size: 25, weight: .bold, design: .rounded))
                            .foregroundColor(self.isDonutLiked ? Color(.red) : Color(.gray))
                            .offset(x: self.isDonutInfoShowing ? 0 : 1200, y: 0)
                            .onTapGesture {
                                
                                self.hapticsEngine.likeFunctionVibration()
                                self.likedDonutViewModel.isDonutLiked.toggle()
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + self.buttonAnimationDuration) {
                                    withAnimation(.spring(response: buttonAnimationDuration, dampingFraction: 1)) {
                                        self.isLikedButtonAnimated = false
                                        self.isDonutLiked.toggle()
                                        if !self.isDonutLiked {
                                            Task {
                                                await self.likedDonutViewModel.deleteDonutFromLikedDonuts(name: self.name)
                                            }
                                        }
                                    }
                                }
                                
                                if self.likedDonutViewModel.isDonutLiked {
                                    self.likedDonutViewModel.addToLikedDonuts(name: self.name, description: self.description, imgUrl: self.imgUrl, category: self.category, price: self.price, sellCount: self.sellCount)
                                }
                                
                                if !self.isDonutLiked {
                                    Task {
                                        
                                    }
                                }
                                
                            }
                            .scaleEffect(self.isLikedButtonAnimated ? self.likedButtonAnimationScale : 1)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("$\(self.price) c/u")
                            .font(.system(size: 22, weight: .black, design: .rounded))
                            .foregroundColor(Color("fontColor"))
                        
                        Text(String(describing: self.description).replacingOccurrences(of: "\\n", with: "\n\n"))
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .foregroundColor(Color("fontColor"))
                            .padding(.top, 10)
                    }
                }
    //            .matchedGeometryEffect(id: "\(self.donutModel.name)info", in: animation)
                .offset(x: self.isDonutInfoShowing ? 0 : -800, y: 0)
                .padding(.horizontal, 10)
                
                VStack(alignment: .trailing) {
                    HStack {
                        Spacer()
                        
                        Button {
                            self.quantity -= 1
                            if self.quantity < 1 {
                                self.quantity = 1
                            }
                        } label: {
                            VStack {
                                Image(systemName: "minus")
                                    .font(.system(size: 32, weight: .black, design: .rounded))
                                    .foregroundColor(Color("buttonTextColor"))
                                    .padding(4)
                                    .frame(width: 40, height: 40)
                            }
                            .background(
                                self.donutModel.category == "glaseadas" ? Color("pink") :
                                    self.donutModel.category == "chocolate" ? Color("green") :
                                    self.donutModel.category == "normal" ? Color("blue") :
                                    self.donutModel.category == "rellenas" ? Color("purple") :
                                    Color("green")
                            )
                            .cornerRadius(12)
                            .shadow(color: Color("shadow"), radius: 1, x: 0, y: 1)
                            
                        }
                        
                        Text("\(self.quantity)")
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .foregroundColor(Color("fontColor"))
                            .padding(.leading, 5)
                            .background(
                                RoundedRectangle(cornerRadius: 15, style: .continuous)
                                    .foregroundColor(Color("textField"))
                                    .shadow(color: Color("shadow"), radius: 0.5, x: 0, y: 1)
                                    .frame(width: 70,height: 40, alignment: .leading)
                            )
                            .frame(width: 70)
                        
                        
                        Button {
                            self.quantity += 1
                            if self.quantity > 20 {
                                self.quantity = 20
                            }
                        } label: {
                            VStack {
                                Image(systemName: "plus")
                                    .font(.system(size: 32, weight: .black, design: .rounded))
                                    .foregroundColor(Color("buttonTextColor"))
                                    .padding(4)
                                    .frame(width: 40, height: 40)
                            }
                            .background(
                                self.donutModel.category == "glaseadas" ? Color("pink") :
                                    self.donutModel.category == "chocolate" ? Color("green") :
                                    self.donutModel.category == "normal" ? Color("blue") :
                                    self.donutModel.category == "rellenas" ? Color("purple") :
                                    Color("green")
                            )
                            .cornerRadius(15)
                            .shadow(color: Color("shadow"), radius: 1, x: 0, y: 1)
                        }
                        
                    }
                }
                .padding(.horizontal, 10)
                .padding(.top, 40)
                .offset(x: self.isDonutInfoShowing ? 0 : 800, y: 0)
                
                HStack {
                    Spacer()
                    
                    Text("$\(self.price * self.quantity)")
                        .font(.system(size: 22, weight: .black, design: .rounded))
                        .foregroundColor(Color("fontColor"))
                    
                    Button {
    //                    self.isDonutSelected = false
                        shoppingCartViewModel.addToShoppingCart(donut: self.donutModel, quantity: self.quantity, quantityPrice: (self.price * self.quantity))
                    } label: {
                        VStack {
                            Image(systemName: "cart.fill.badge.plus")
                                .font(.system(size: 28, weight: .black, design: .rounded))
                                .foregroundColor(Color("buttonTextColor"))
                                .padding(4)
                                .frame(width: 45, height: 45)
                        }
                        .background(
                            self.donutModel.category == "glaseadas" ? Color("pink") :
                                self.donutModel.category == "chocolate" ? Color("green") :
                                self.donutModel.category == "normal" ? Color("blue") :
                                self.donutModel.category == "rellenas" ? Color("purple") :
                                Color("green")
                        )
                        .cornerRadius(15)
                        .shadow(color: Color("shadow"), radius: 1, x: 0, y: 1)
                    }
                    
                }
                .padding(.top, 40)
                .padding(.trailing, 10)
                .offset(x: 0, y: self.isDonutInfoShowing ? 0 : 1200)
                
                Spacer()
                Spacer()
            }
            .padding(.bottom, 80)
            
        }
        .ignoresSafeArea()
        .background(
            RoundedRectangle(cornerRadius: 35)
                .matchedGeometryEffect(id: "\(self.donutModel.name)CardForm", in: animation)
                .foregroundColor(Color("background"))
                .cornerRadius(35)
                .shadow(color: Color("shadow"), radius: 2, x: 0, y: 1)
        )
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            
            Task {
                self.isDonutLiked = await self.likedDonutViewModel.checkIfDonutAlreadyLiked(donut: self.donutModel)
            }
            
            withAnimation(.spring(response: 0.7, dampingFraction: 1)) {
                self.isDonutInfoShowing = true
            }
            
        }
        .environmentObject(shoppingCartViewModel)
    }
}

struct DonutView_Previews: PreviewProvider {
    
    @Namespace static var animation
    @State static var imgUrl = "https://firebasestorage.googleapis.com/v0/b/happydonutsapp.appspot.com/o/Chocolate%20crunch.png?alt=media&token=7445cc1e-233f-42d1-aaee-2feb69d72dca"
    @State static var name = "Choco Crunch"
    @State static var price = 1800
    @State static var description = "Donut bañada en en manjar, con sufflés crocantes de chocolate y salsa de chocolate. \n\nEsta donut fue creada pensando en el paladar de los fanáticos de lo crocante y el chocolate."
    @State static var category = "chocolate"
    @State static var sellCount = 1800
    
    static var previews: some View {
        DonutView(donutModel: DonutModel.init(), animation: animation, imgUrl: $imgUrl, name: $name, price: $price, description: $description, isDonutSelected: .constant(false), dismissedDonut: $name, category: $category, sellCount: $sellCount)
    }
}

