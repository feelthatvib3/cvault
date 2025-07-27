//
//  AppDelegate.swift
//  cvault
//
//  Created by feelthatvib3 on 7/27/25.
//

import AppKit
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    var statusItem: NSStatusItem?
    var popover: NSPopover!
    
    let store = ClipboardStore()
    let monitor = ClipboardMonitor()
    
    func applicationWillTerminate(_ notification: Notification) {
        if let item = statusItem {
            NSStatusBar.system.removeStatusItem(item)
        }
    }
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
        
        if let button = statusItem?.button {
            button.image = NSImage(systemSymbolName: "tray.full", accessibilityDescription: "Clipboard Vault")
            button.action = #selector(togglePopover(_:))
        }
        
        monitor.onNewCopy = { copied in
            DispatchQueue.main.async {
                self.store.add(copied)
            }
        }
        
        monitor.start()
        
        popover = NSPopover()
        popover.contentSize = NSSize(width: 300, height: 350)
        popover.behavior = .transient
        popover.contentViewController = NSHostingController(rootView: ClipboardPopover(store: store))

    }
    
    @objc func togglePopover(_ sender: AnyObject?) {
        if let button = statusItem?.button {
            if popover.isShown {
                popover.performClose(sender)
            } else {
                popover.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)
            }
        }
    }
}
