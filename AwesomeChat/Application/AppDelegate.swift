//
//  AppDelegate.swift
//  AwesomeChat
//
//  Created by đào sơn on 01/03/2024.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow()
        let applicationNavigator = ApplicationNavigator()
        self.window?.rootViewController = applicationNavigator.configMainInterface()
        self.window?.makeKeyAndVisible()
        return true
    }
}
