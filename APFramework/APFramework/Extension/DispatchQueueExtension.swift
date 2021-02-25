//
//  DispatchQueueExtension.swift
//  APFramework
//
//  Created by Apple on 2017/8/1.
//  Copyright © 2017年 The_X All rights reserved.
//

import Foundation

extension DispatchQueue {
    
    static var `default`: DispatchQueue { return DispatchQueue.global(qos: .`default`) }
    static var userInteractive: DispatchQueue { return DispatchQueue.global(qos: .userInteractive) }
    static var userInitiated: DispatchQueue { return DispatchQueue.global(qos: .userInitiated) }
    static var utility: DispatchQueue { return DispatchQueue.global(qos: .utility) }
    static var background: DispatchQueue { return DispatchQueue.global(qos: .background) }
    
    func after(_ delay: TimeInterval, execute closure: @escaping () -> Void) {
        asyncAfter(deadline: .now() + delay, execute: closure)
    }
    
    private static var _onceTracker = [String]()
    public class func once(block:()->Void) {
        let token = UUID().uuidString
        objc_sync_enter(self)
        defer { objc_sync_exit(self) }
        
        if _onceTracker.contains(token) {
            return
        }
        _onceTracker.append(token)
        block()
    }
    
    @discardableResult
    func scheduledTimer(timeInterval: TimeInterval, repeatCount: Int, handler: @escaping (Int)->()) -> DispatchSourceTimer? {
        if repeatCount <= 0 { return nil }
        var count = repeatCount
        let timer = DispatchSource.makeTimerSource(flags: [], queue: self)
        timer.schedule(deadline: .now(), repeating: timeInterval)
        timer.setEventHandler {
            count -= 1
            DispatchQueue.main.async {
                handler(count)
            }
            if count == 0 { timer.cancel() }
        }
        timer.resume()
        
        return timer
    }
}
