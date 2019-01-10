//
//  AppDelegate.swift
//  CRUDExampleApp
//
//  Created by dejan kraguljac on 02/01/2019.
//  Copyright © 2019 ReRoot. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window?.rootViewController = UINavigationController(rootViewController: MainViewController()) 
        return true
    }

}

