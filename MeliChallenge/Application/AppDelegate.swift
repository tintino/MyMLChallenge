//
//  AppDelegate.swift
//  MeliChallenge
//
//  Created by Martin Gonzalez Vega on 25/10/2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: - properties
    
    var coordinator: CoordinatorProtocol?
    var window: UIWindow?

    // MARK: -  UIApplicationDelegate
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        initWindow()
        return true
    }

    // MARK: - private methods
    
    private func initWindow() {
        coordinator = MainCoordinator()
        coordinator?.start()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = coordinator?.rootViewController
        window?.makeKeyAndVisible()
    }
}

