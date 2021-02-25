//
//  QTabBarController.swift
//  APFramework
//
//  Created by Apple on 2018/1/22.
//  Copyright © 2018年 The_X. All rights reserved.
//

import UIKit

class QTabBarController: UITabBarController {
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.isTranslucent = false
    }
}

extension QTabBarController {
    
    private func addChildrenViewControllers() {

    }
    
    private func setupChildernController(childernVC: UIViewController, title: String, image: String) {
        
        childernVC.tabBarItem.title = title
        
        childernVC.tabBarItem.image = UIImage(named: "tabbar_" + image)
        childernVC.tabBarItem.selectedImage = UIImage(named: "tabbar_" + image + "_selected")?.withRenderingMode(.alwaysOriginal)
        
        childernVC.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12)], for: .normal)
        childernVC.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.orange], for: .selected)
        
        let navVC = QNavigationController(rootViewController: childernVC)
        addChild(navVC)
    }
}

extension QTabBarController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
