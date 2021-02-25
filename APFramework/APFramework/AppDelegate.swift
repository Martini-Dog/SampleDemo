//
//  AppDelegate.swift
//  APFramework
//
//  Created by Apple on 2018/1/10.
//  Copyright © 2018年 The_X. All rights reserved.
//

import UIKit
import UserNotifications
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    // MARK: - Application Life Cycle

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        window?.rootViewController = QNavigationController(rootViewController: QHomeViewController())
        window?.makeKeyAndVisible()

//        printf(NSHomeDirectory())
        applicationAdditionConfig(application)
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        
        // 清除角标
        application.applicationIconBadgeNumber = 0
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }
    
    /** 应用额外配置 */
    func applicationAdditionConfig(_ application: UIApplication) {
        
        // 清除角标
        application.applicationIconBadgeNumber = 0
        
        // 键盘管理
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        
    }
}

// MARK: - 第三方框架的集成配置

extension AppDelegate {
    
    func applicationThirdPartyConfig() {
        
    }
}
