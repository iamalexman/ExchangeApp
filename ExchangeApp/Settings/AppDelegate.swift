//
//  AppDelegate.swift
//  ExchangeApp
//
//  Created by Кузнецов Александр Алексеевич on 18.07.2022.
//

import UIKit

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        setup()
        
        return true
    }
    
    private func setup() {
        
        let rootView = LoginRouter.createModule()
//        let rootView = NewsRouter.createModule()
        let navigation = UINavigationController(rootViewController: rootView)
        let appearance = UINavigationBarAppearance()
        
        navigation.navigationBar.scrollEdgeAppearance = appearance
        appearance.backgroundColor = .lightGray.withAlphaComponent(0.2)
        
        window!.rootViewController = navigation
        window?.makeKeyAndVisible()
    }
    
    func appDelegate() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
}

