//
//  ViewController.swift
//  APFramework
//
//  Created by Apple on 2018/1/10.
//  Copyright © 2018年 The_X. All rights reserved.
//

import UIKit
import AVFoundation
import VideoToolbox
import CoreBluetooth

class ViewController: UIViewController {
    
    private lazy var captureSession = AVCaptureSession()
    
    private lazy var BLEManager = CBCentralManager(delegate: self, queue: DispatchQueue.global())
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        printf(BLEManager)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        captureSession.startRunning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        drawPDF()
    }
}

extension ViewController: CBCentralManagerDelegate {
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOn:
//            central.scanForPeripherals(withServices: nil, options: nil)
        printf("1111")
        default:
            printf("!!!!")
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        printf(peripheral)
    }
}

extension ViewController {
    
    // MARK: - Layer Animation
    
    private func drawLayer() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.backgroundColor = UIColor.yellow.cgColor
        shapeLayer.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 50, height: 16), cornerRadius: 4).cgPath
        shapeLayer.fillColor = UIColor.lightGray.withAlphaComponent(0.8).cgColor
        //        shapeLayer.bounds = CGRect(x: 0, y: 0, width: 50, height: 16)
        //        shapeLayer.position = view.layer.position
        //        shapeLayer.anchorPoint = CGPoint(x: 1, y: 0)
        //        view.layer.addSublayer(shapeLayer)
        
        
        let animation = CABasicAnimation(keyPath: "fillColor")
        //        animation.fromValue = UIColor.white.cgColor
        animation.toValue = UIColor.white.cgColor
        animation.duration = 0.35
        animation.repeatCount = MAXFLOAT
        animation.autoreverses = true
        //        animation.fillMode = .forwards
        
        shapeLayer.add(animation, forKey: nil)
        
        
        
        let s = CAReplicatorLayer()
        s.addSublayer(shapeLayer)
        s.bounds = CGRect(x: 0, y: 0, width: 280, height: 16)
        s.position = view.layer.position
        
        
        s.instanceCount = 5
        s.instanceTransform = CATransform3D(translationX: 55, y: 0, z: 0)
        s.instanceDelay = 1
        
        view.layer.addSublayer(s)
    }
    
    private func drawPDF() {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! + "test.pdf"
        let success = UIGraphicsBeginPDFContextToFile(path, CGRect(x: 0, y: 0, width: 210 * 3, height: 297 * 3), [:])
        if success {
            for _ in 0...1 {
                UIGraphicsBeginPDFPage()
                let biz = UIBezierPath(rect: CGRect(x: 100, y: 100, width: 100, height: 100))
                UIColor.red.setStroke()
                biz.stroke()
            }
        }
        UIGraphicsEndPDFContext()
    }
    
    // MARK: -  AVCapture Camera
    
    private func camera() {
        guard let device = AVCaptureDevice.default(for: .video), let input = try? AVCaptureDeviceInput(device: device) else { return }
        
        let dataOutput = AVCaptureVideoDataOutput()
        let dataQueue = DispatchQueue(label: "com.videoDataQueue")
        dataOutput.setSampleBufferDelegate(self, queue: dataQueue)
        
        if captureSession.canAddInput(input) { captureSession.addInput(input) }
        if captureSession.canAddOutput(dataOutput) { captureSession.addOutput(dataOutput) }
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight - 200) //view.bounds
        view.layer.addSublayer(previewLayer)
    }
    
    private func cameraWithPostion(position: AVCaptureDevice.Position = .back) -> AVCaptureDevice? {
//        var device: AVCaptureDevice
        if #available(iOS 13.0, *) {
            guard let device = AVCaptureDevice.default(.builtInDualWideCamera, for: .video, position: position) else { return nil }
            return device
        } else {
            guard let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: position) else { return nil }
            return device
        }
    }
    
    private func player() {
        
    }
}

extension ViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        
        printf(sampleBuffer)
        
        let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)
        let imageCI = CIImage(cvImageBuffer: imageBuffer!)
        let image = UIImage(ciImage: imageCI)
        
//        sampleBuffer.imageBuffer
        
//        VTCompressionSessionEncodeFrame(<#T##session: VTCompressionSession##VTCompressionSession#>, imageBuffer: <#T##CVImageBuffer#>, presentationTimeStamp: <#T##CMTime#>, duration: <#T##CMTime#>, frameProperties: <#T##CFDictionary?#>, infoFlagsOut: <#T##UnsafeMutablePointer<VTEncodeInfoFlags>?#>, outputHandler: <#T##VTCompressionOutputHandler##VTCompressionOutputHandler##(OSStatus, VTEncodeInfoFlags, CMSampleBuffer?) -> Void#>)
//        
//        VTCompressionSessionEncodeFrame(<#T##session: VTCompressionSession##VTCompressionSession#>, imageBuffer: <#T##CVImageBuffer#>, presentationTimeStamp: <#T##CMTime#>, duration: <#T##CMTime#>, frameProperties: <#T##CFDictionary?#>, sourceFrameRefcon: <#T##UnsafeMutableRawPointer?#>, infoFlagsOut: <#T##UnsafeMutablePointer<VTEncodeInfoFlags>?#>)
//
//        VTCompressionSessionCreate(allocator: nil, width: <#T##Int32#>, height: <#T##Int32#>, codecType: kCMVideoCodecType_H264, encoderSpecification: nil, imageBufferAttributes: nil, compressedDataAllocator: nil, outputCallback: { (outputCallbackRefCon, sourceFrameRefCon, status, infoFlags, sampleBuffer) in
//            <#code#>
//        }, refcon: <#T##UnsafeMutableRawPointer?#>, compressionSessionOut: <#T##UnsafeMutablePointer<VTCompressionSession?>#>)
        
        
        
    }
}
