//
//  AppDelegate.swift
//  Wisdomleaf-Task
//
//  Created by Dinesh Kumar on 21/04/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setUpRootView()
        return true
    }
    
}

extension AppDelegate {
    
    func setUpRootView() {
        /// Create a new UIWindow instance with the size of the screen
        /// Set the root view controller for the window wrapped in a UINavigationController
        /// Make the window visible
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = SplashViewController()
        window?.makeKeyAndVisible()
        
        /// Delay of 5 seconds before switching to the main view controller
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            self.window?.rootViewController = ViewController()
        }
    }
}
