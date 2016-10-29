//
//  AppDelegate.swift
//  Tomatoes
//
//  Created by Paolo Tagliani on 20/10/16.
//  Copyright © 2016 Tomatoes. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let networkService = ServiceProvider.sharedInstance.networkService

        //TODO: debug purpose only, remove when login feature is completed
        networkService.logout()

        if networkService.isLogged() {
            print("User is logged in.")
        }
        else {
            print("User not logged, will show login screen")
            let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Login")
            self.window?.makeKeyAndVisible()
            self.window?.rootViewController?.present(viewController, animated: false, completion: nil)
        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }

}

