//
//  Happy_DonutsApp.swift
//  Happy Donuts
//
//  Created by Jacob Aguilar on 22-07-22.
//

import SwiftUI
import FirebaseCore

@main
struct Happy_DonutsApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
//    @StateObject var shoppingCartViewModel = ShoppingCartViewModel()
    
    var body: some Scene {
        WindowGroup {
            SplashScreenView()
//                .environmentObject(shoppingCartViewModel)
        }
    }
}


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}
