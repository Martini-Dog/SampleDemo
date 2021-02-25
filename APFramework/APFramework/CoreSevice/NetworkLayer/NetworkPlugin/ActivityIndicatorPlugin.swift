//
//  ActivityIndicatorPlugin.swift
//  APFramework
//
//  Created by Apple on 2018/2/5.
//  Copyright © 2018年 The_X. All rights reserved.
//

import Moya


private enum ActivityIndicatorState {
    case notActive, delayingStart, active, delayingCompletion
}

final class ActivityIndicatorPlugin: PluginType {

    public var isEnabled: Bool {
        get {
            lock.lock() ; defer { lock.unlock() }
            return enabled
        }
        set {
            lock.lock() ; defer { lock.unlock() }
            enabled = newValue
        }
    }
    
    public init(_ isEnabled: Bool = true) {
        
        self.isEnabled = isEnabled
    }
    
    deinit {
        
        invalidateStartDelayTimer()
        invalidateCompletionDelayTimer()
    }
    
    /// A boolean value indicating whether the network activity indicator is currently visible.
    public private(set) var isNetworkActivityIndicatorVisible: Bool = false {
        didSet {
            guard isNetworkActivityIndicatorVisible != oldValue else { return }
            
            DispatchQueue.main.async {
                
                UIApplication.shared.isNetworkActivityIndicatorVisible = self.isNetworkActivityIndicatorVisible
            }
        }
    }
    
    /// A time interval indicating the minimum duration of networking activity that should occur before the activity
    /// indicator is displayed. Defaults to `1.0` second.
    public var startDelay: TimeInterval = 1.0
    
    /// A time interval indicating the duration of time that no networking activity should be observed before dismissing
    /// the activity indicator. This allows the activity indicator to be continuously displayed between multiple network
    /// requests. Without this delay, the activity indicator tends to flicker. Defaults to `0.2` seconds.
    public var completionDelay: TimeInterval = 0.3
    
    /// Called by the provider as soon as the request is about to start
    func willSend(_ request: RequestType, target: TargetType) {
        
        incrementActivityCount()
    }
    
    /// Called after a response has been received, but before the MoyaProvider has invoked its completion handler.
    func didReceive(_ result: Result<Moya.Response, MoyaError>, target: TargetType) {

        decrementActivityCount()
    }
    
    // MARK: - Private - Property
    
    private var activityCount: Int = 0
    private var enabled: Bool = true
    
    private var startDelayTimer: Timer?
    private var completionDelayTimer: Timer?
    
    private let lock = NSLock()
    
    // MARK: - Private - Activity Indicator State
    
    private func updateActivityIndicatorStateForNetworkActivityChange() {
        guard enabled else { return }
        
        switch activityIndicatorState {
        case .notActive:
            if activityCount > 0 { activityIndicatorState = .delayingStart }
        case .delayingStart:
            // No-op - let the delay timer finish
            break
        case .active:
            if activityCount == 0 { activityIndicatorState = .delayingCompletion }
        case .delayingCompletion:
            if activityCount > 0 { activityIndicatorState = .active }
        }
    }
    
    private var activityIndicatorState: ActivityIndicatorState = .notActive {
        didSet {
            switch activityIndicatorState {
            case .notActive:
                isNetworkActivityIndicatorVisible = false
                invalidateStartDelayTimer()
                invalidateCompletionDelayTimer()
            case .delayingStart:
                scheduleStartDelayTimer()
            case .active:
                invalidateCompletionDelayTimer()
                isNetworkActivityIndicatorVisible = true
            case .delayingCompletion:
                scheduleCompletionDelayTimer()
            }
        }
    }
    
    // MARK: - Private -  Activity Count
    
    private func incrementActivityCount() {
        lock.lock() ; defer { lock.unlock() }
        
        activityCount += 1
        updateActivityIndicatorStateForNetworkActivityChange()
    }
    
    private func decrementActivityCount() {
        lock.lock() ; defer { lock.unlock() }
        
        activityCount -= 1
        updateActivityIndicatorStateForNetworkActivityChange()
    }
    
    // MARK: - Private - Timers
    
    private func scheduleStartDelayTimer() {
        let timer = Timer(timeInterval: startDelay, target: self,
            selector: #selector(startDelayTimerFired),
            userInfo: nil, repeats: false)
        
        DispatchQueue.main.async {
            RunLoop.main.add(timer, forMode: RunLoop.Mode.common)
            RunLoop.main.add(timer, forMode: RunLoop.Mode.tracking)
        }
        
        startDelayTimer = timer
    }
    
    private func scheduleCompletionDelayTimer() {
        let timer = Timer(timeInterval: completionDelay, target: self,
            selector: #selector(completionDelayTimerFired),
            userInfo: nil, repeats: false)
        
        DispatchQueue.main.async {
            RunLoop.main.add(timer, forMode: RunLoop.Mode.common)
            RunLoop.main.add(timer, forMode: RunLoop.Mode.tracking)
        }
        
        completionDelayTimer = timer
    }
    
    @objc private func startDelayTimerFired() {
        lock.lock() ; defer { lock.unlock() }
        
        if activityCount > 0 {
            activityIndicatorState = .active
        } else {
            activityIndicatorState = .notActive
        }
    }
    
    @objc private func completionDelayTimerFired() {
        lock.lock() ; defer { lock.unlock() }
        activityIndicatorState = .notActive
    }
    
    private func invalidateStartDelayTimer() {
        startDelayTimer?.invalidate()
        startDelayTimer = nil
    }
    
    private func invalidateCompletionDelayTimer() {
        completionDelayTimer?.invalidate()
        completionDelayTimer = nil
    }
}
