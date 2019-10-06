//
//  AppDelegate.swift
//  VideoApp
//
//  Created by Beherith on 06.09.19.
//  Copyright © 2019 Beherith. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        guard NSClassFromString("XCTest") == nil else { return false }
        
        let navigationController = window!.rootViewController as! UINavigationController
        let flowController = RootFlowController(navigationController: navigationController)
        flowController.start()
        
        return true
    }
}

