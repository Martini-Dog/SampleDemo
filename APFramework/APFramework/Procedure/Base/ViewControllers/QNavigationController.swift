//
//  QNavigationController.swift
//  APFramework
//
//  Created by Apple on 2018/2/26.
//  Copyright © 2018年 The_X. All rights reserved.
//

import UIKit

enum QNavigationBarStyle {
    case theme
    case clear
    case white
}

class QNavigationController: UINavigationController {

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        interactivePopGestureRecognizer?.delegate = self
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        if children.count > 0 {
            
            viewController.hidesBottomBarWhenPushed = true
        }
        
        super.pushViewController(viewController, animated: true)
    }
}

extension QNavigationController: UIGestureRecognizerDelegate {
    
}

extension QNavigationController {
    
    override var prefersStatusBarHidden: Bool {
        guard let topVC = topViewController else { return false }
        return topVC.prefersStatusBarHidden
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        guard let topVC = topViewController else { return .default }
        return topVC.preferredStatusBarStyle
    }
    
    override var shouldAutorotate: Bool {
        guard let topVC = topViewController else { return true }
        return topVC.shouldAutorotate
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        guard let topVC = topViewController else { return .portrait }
        return topVC.supportedInterfaceOrientations
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        guard let topVC = topViewController else { return .portrait }
        return topVC.preferredInterfaceOrientationForPresentation
    }
    
}

extension UINavigationController {
    
    func barStyle(_ style: QNavigationBarStyle) {
        switch style {
        case .theme:
            navigationBar.barStyle = .black
            navigationBar.setBackgroundImage(UIColor.theme.image(), for: .default)
            navigationBar.shadowImage = UIImage()
        case .clear:
            navigationBar.barStyle = .black
            navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationBar.shadowImage = UIImage()
        case .white:
            navigationBar.barStyle = .default
            navigationBar.setBackgroundImage(UIColor.white.image(), for: .default)
            navigationBar.shadowImage = nil
        }
    }
}
