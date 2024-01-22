//
//  SplashScreenView.swift
//  Happy Donuts
//
//  Created by Jacob Aguilar on 22-07-22.
//

import SwiftUI

struct SplashScreenView: View {
    
    @StateObject var profileViewModel = ProfileViewModel()
    @State var isAnimationActive: Bool = false
    
    var body: some View {
        ZStack {
            Color("pink")
                .ignoresSafeArea()
            
            VStack {
                if self.isAnimationActive {
                    withAnimation(Animation.easeOut) {
                        LoginView()
                            .transition(.move(edge: .bottom))
                    }
                } else {
                    LottieImage(name: "DonutAnimation", loopMode: .playOnce)
                        .frame(width: 120, height: 120)
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation {
                        self.isAnimationActive = true
                    }
                }
            }
            
        }
        .onAppear {
            Task {
                await self.profileViewModel.getUserExtraData()
            }
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
