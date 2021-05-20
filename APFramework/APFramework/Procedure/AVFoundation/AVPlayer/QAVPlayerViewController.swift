//
//  QAVPlayerViewController.swift
//  APFramework
//
//  Created by viatom on 2020/11/9.
//  Copyright © 2020 The_X. All rights reserved.
//

import UIKit

class QAVPlayerViewController: QBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    let playerView = QPlayerView()
}

extension QAVPlayerViewController {
    
    override func configurtionUI() {
        
        view.addSubview(playerView)
        playerView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}
