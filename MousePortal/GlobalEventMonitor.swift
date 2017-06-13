//
//  GlobalEventMonitor.swift
//  Mouse Portal
//
//  Created by Jimmy Tran on 6/12/17.
//  Copyright © 2017 Jimmy Tran. All rights reserved.
//

import Cocoa

open class GlobalEventMonitor {
    
    private var monitor: AnyObject?
    private let mask: NSEventMask
    private let handler: (NSEvent) -> ()
    
    public init(mask: NSEventMask, handler: @escaping (NSEvent) -> ()) {
        self.mask = mask
        self.handler = handler
    }
    
    deinit {
        stop()
    }
    
    public func start() {
        monitor = NSEvent.addGlobalMonitorForEvents(matching: mask, handler: handler) as AnyObject
    }
    
    public func stop() {
        if monitor != nil {
            NSEvent.removeMonitor(monitor!)
            monitor = nil
        }
    }
}
