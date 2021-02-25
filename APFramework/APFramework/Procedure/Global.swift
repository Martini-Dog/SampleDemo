//
//  Global.swift
//  APFramework
//
//  Created by Apple on 2018/2/26.
//  Copyright © 2018年 The_X. All rights reserved.
//

import UIKit
import Then
import SnapKit
import Kingfisher
import SwifterSwift

/** 屏幕宽度 */
let kScreenWidth = UIScreen.main.bounds.width
/** 屏幕高度 */
let kScreenHeight = UIScreen.main.bounds.height

var topVC: UIViewController? {
    var resultVC: UIViewController?
    resultVC = _topVC(UIApplication.shared.keyWindow?.rootViewController)
    while resultVC?.presentedViewController != nil {
        resultVC = _topVC(resultVC?.presentedViewController)
    }
    return resultVC
}

private func _topVC(_ vc: UIViewController?) -> UIViewController? {
    if vc is UINavigationController {
        return _topVC((vc as? UINavigationController)?.topViewController)
    } else if vc is UITabBarController {
        return _topVC((vc as? UITabBarController)?.selectedViewController)
    } else {
        return vc
    }
}

extension UIColor {
    
    /** 背景颜色 */
    open class var background: UIColor { return UIColor.hexColor("#F3F3F3") }
    /** 主题颜色 */
    open class var theme: UIColor { return UIColor.hexColor("#FFE4E1") }
    
//    open class var
}


//MARK: Kingfisher

extension KingfisherWrapper where Base: KFCrossPlatformImageView {
    @discardableResult
    public func setImage(urlString: String?, placeholder: Placeholder? = UIImage(named: "normal_placeholder_h")) -> DownloadTask? {
        return setImage(with: URL(string: urlString ?? ""),
                        placeholder: placeholder,
                        options:[.transition(.fade(0.5))])
    }
}

extension KingfisherWrapper where Base: UIButton {
    @discardableResult
    public func setImage(urlString: String?, for state: UIControl.State, placeholder: UIImage? = UIImage(named: "normal_placeholder_h")) -> DownloadTask? {
        return setImage(with: URL(string: urlString ?? ""),
                        for: state, placeholder: placeholder,
                        options: [.transition(.fade(0.5))])
    }
}

//MARK: SnapKit

extension ConstraintView {
    
    var usnp: ConstraintBasicAttributesDSL {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.snp
        } else {
            return self.snp
        }
    }
}


/** 自定义调试打印 */
func printf<T>(_ message: T, file: String = #file, function: String = #function, lineNumber: Int = #line) {
    #if DEBUG
        let fileName = (file as NSString).lastPathComponent
        print("[file: \(fileName), funciton: \(function), line: \(lineNumber)]: \n\(message)")
    #endif
}
