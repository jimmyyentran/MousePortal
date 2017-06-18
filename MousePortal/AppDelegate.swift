//
//  AppDelegate.swift
//  Mouse Portal
//
//  Created by Jimmy Tran on 6/12/17.
//  Copyright © 2017 Jimmy Tran. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var eventHandler: GlobalEventMonitor?
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        var x = CGFloat();
        var y = CGFloat();
        let displayLx = CGFloat(1280)
        let displayRx = CGFloat(1680)
        let displayLy = CGFloat(1050)
        let pad = CGFloat(5)
        let displayLxPad = displayLx - pad
        let displayRxPad = displayRx + pad
        
        eventHandler = GlobalEventMonitor(mask: NSEventMask.mouseMoved, handler: { (mouseEvent: NSEvent) in
            if mouseEvent.locationInWindow.y >= displayLy {
                x = mouseEvent.locationInWindow.x
                y = mouseEvent.locationInWindow.y
                if x > displayLxPad && x <= displayLx {
                    let eventRef = CGEvent(mouseEventSource: nil, mouseType: CGEventType.mouseMoved, mouseCursorPosition: CGPoint(x: displayRxPad, y: -y + displayLy), mouseButton: CGMouseButton.center)
                    eventRef?.post(tap: CGEventTapLocation.cghidEventTap)
                }
                if x < displayRxPad && x >= displayRx {
                    let eventRef = CGEvent(mouseEventSource: nil, mouseType: CGEventType.mouseMoved, mouseCursorPosition: CGPoint(x: displayLxPad, y: -y + displayLy), mouseButton: CGMouseButton.center)
                    eventRef?.post(tap: CGEventTapLocation.cghidEventTap)
                }
            }
        })
        eventHandler?.start()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

