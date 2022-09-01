//
//  AppDelegate.swift
//  Garage App
//
//  Created by Ankit Singh on 01/09/22.
//

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.configureRealm()
        self.setInitialScreen()
        return true
    }
    
    private func configureRealm() {
        var config = Realm.Configuration()
        config.deleteRealmIfMigrationNeeded = true
        Realm.Configuration.defaultConfiguration = config
    }
    
    func shared() -> AppDelegate{
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    private func setInitialScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle:.main)
        if UserLoginManager.shared.currentUser != nil {
            let vc = storyboard.instantiateViewController(identifier: "DashboardViewController") as! DashboardViewController
            self.shared().window?.rootViewController = vc
            self.shared().window?.makeKeyAndVisible()
        }else{
            let vc = storyboard.instantiateViewController(identifier: "LoginViewController")
            self.shared().window?.rootViewController = vc
            self.shared().window?.makeKeyAndVisible()
        }
    }

}

