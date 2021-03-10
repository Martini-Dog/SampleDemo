//
//  QSystemCamera.swift
//  APFramework
//
//  Created by viatom on 2020/11/17.
//  Copyright © 2020 The_X. All rights reserved.
//

import UIKit
import AVFoundation

// MARK: - 将采集的裸数据抛出, 方便外部调试

protocol QSystemCameraDelegate: NSObjectProtocol {
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection)
}

// MARK: -

class QSystemCamera: UIView {
    
    weak open var delegate: QSystemCameraDelegate?
    
    // MARK: -
    
    open func startCapturing() { sessionQueue.async { self.captureSession.startRunning() } }

    open func stopCapturing() { sessionQueue.async { self.captureSession.stopRunning() } }
    
    public func takePhoto(_ delay: Int = 0) {
        
    }
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configurationCamera()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    
    /** 捕捉会话 */
    private(set) var captureSession = AVCaptureSession()
    /** 相机串行队列*/
    private lazy var sessionQueue = DispatchQueue(label: "com.systemCameraQueue")
    /** 照片输出 */
    private lazy var photoOutput = AVCapturePhotoOutput()
    /** 视频帧输出 */
    private lazy var videoOutput = AVCaptureVideoDataOutput().then { $0.setSampleBufferDelegate(self, queue: sessionQueue) }
    /** 音频原始数据输出 */
    private lazy var audioOutput = AVCaptureAudioDataOutput().then { $0.setSampleBufferDelegate(self, queue: sessionQueue) }
}

// MARK: - AVCapturePhotoCaptureDelegate, AVCaptureVideoDataOutputSampleBufferDelegate

extension QSystemCamera: AVCapturePhotoCaptureDelegate, AVCaptureVideoDataOutputSampleBufferDelegate, AVCaptureAudioDataOutputSampleBufferDelegate {
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        // 向外抛出
        delegate?.captureOutput(output, didOutput: sampleBuffer, from: connection)
        
//        DispatchQueue.main.async {
//            let previewLayer = self.layer as! AVSampleBufferDisplayLayer
//            previewLayer.enqueue(sampleBuffer)
//        }
        
    }
    
}

// MARK: - Configuration

extension QSystemCamera {

    private func configurationCamera() {
        guard let videoDevice = AVCaptureDevice.default(for: .video), let videoInput = try? AVCaptureDeviceInput(device: videoDevice) else { printf("未找到视频输入源"); return }
        if let audioDevice = AVCaptureDevice.default(for: .audio), let audioInput = try? AVCaptureDeviceInput(device: audioDevice) {
            if captureSession.canAddInput(audioInput) {
                captureSession.addInput(audioInput)
            }
        }
        
        let previewLayer = layer as! AVCaptureVideoPreviewLayer
        previewLayer.session = captureSession
        previewLayer.videoGravity = .resizeAspectFill
        // 添加输入源
        if captureSession.canAddInput(videoInput) { captureSession.addInput(videoInput) }
        // 添加输出源
        if captureSession.canAddOutput(photoOutput) { captureSession.addOutput(photoOutput) }
        if captureSession.canAddOutput(videoOutput) { captureSession.addOutput(videoOutput) }
        if captureSession.canAddOutput(audioOutput) { captureSession.addOutput(audioOutput) }
        
        
        if #available(iOS 13.0, *) {
            let discoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera, .builtInTelephotoCamera, .builtInDualCamera, .builtInUltraWideCamera, .builtInDualWideCamera, .builtInTripleCamera], mediaType: .video, position: .unspecified)
            printf(discoverySession.devices)
        } else {
            // Fallback on earlier versions
        }
        
        printf(videoDevice)
     
        
        printf(captureSession.sessionPreset)
        
//        printf(videoOutput.connection(with: .video)?.videoOrientation.rawValue)
//        previewLayer.connection?.videoOrientation = .portraitUpsideDown
        
        if #available(iOS 13.0, *) {
            printf(AVCaptureMultiCamSession.isMultiCamSupported)
        } else {
            // Fallback on earlier versions
        }
    }

    override class var layerClass: AnyClass { return AVCaptureVideoPreviewLayer.self } // AVSampleBufferDisplayLayer
}
