//
//  QBaseViewController.swift
//  APFramework
//
//  Created by Apple on 2018/2/27.
//  Copyright © 2018年 The_X. All rights reserved.
//

import UIKit

class QBaseViewController: UIViewController {

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurtionUI()
        configNavigationBar()
        
        view.backgroundColor = UIColor.background
        if #available(iOS 11.0, *) {
            UIScrollView.appearance().contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension QBaseViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

// MARK: - Configuration ViewController

extension QBaseViewController {
    
    @objc func configurtionUI() {
        
    }
    
    @objc func configNavigationBar() {
        guard let navi = navigationController else { return }
        if navi.visibleViewController == self {
//            navi.barStyle(.theme)
//            navi.navigationBar.prefersLargeTitles = false
        }
    }
    
    override var prefersStatusBarHidden: Bool { return false }
    override var preferredStatusBarStyle: UIStatusBarStyle { return .default }
    
    override var shouldAutorotate: Bool { return true }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask { return .portrait }
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation { return .portrait }
    
    override var modalPresentationStyle: UIModalPresentationStyle { get { return .overFullScreen } set { super.modalPresentationStyle = newValue }  }
}
