//
//  LottieImage.swift
//  Happy Donuts
//
//  Created by Jacob Aguilar on 22-07-22.
//

import SwiftUI
import Lottie

struct LottieImage: UIViewRepresentable {
    
    let name: String
    let loopMode: LottieLoopMode
    let animationView = LottieAnimationView()
    
    func makeUIView(context: Context) -> some UIView {
        let view = UIView(frame: .zero)
 
        animationView.animation = LottieAnimation.named(name)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = loopMode
        animationView.play()
 
        view.addSubview(animationView)
 
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        animationView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
 
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

