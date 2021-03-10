//
//  QCameraViewController.swift
//  APFramework
//
//  Created by viatom on 2020/9/2.
//  Copyright © 2020 The_X. All rights reserved.
//

import UIKit
import AVFoundation

class QCameraViewController: QBaseViewController {
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        systemCamera.startCapturing()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        systemCamera.stopCapturing()
    }
    
    // MARK: -
    
    private lazy var systemCamera = QSystemCamera().then { $0.delegate = self }
}

extension QCameraViewController: QSystemCameraDelegate {
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
//        printf("\(sampleBuffer)")
    }
}

extension QCameraViewController {
    
    override func configurtionUI() {
        super.configurtionUI()
        
        view.addSubview(systemCamera)
        systemCamera.snp.makeConstraints { (make) in
//            make.height.equalTo(250)
            make.edges.left.right.equalToSuperview()
        }
    }
    
    override func configNavigationBar() {
        super.configNavigationBar()
        
        navigationController?.barStyle(.clear)
    }
}
