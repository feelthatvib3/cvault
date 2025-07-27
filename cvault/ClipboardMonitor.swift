//
//  ClipboardMonitor.swift
//  cvault
//
//  Created by feelthatvib3 on 7/27/25.
//

import AppKit

class ClipboardMonitor {
    private let pasteboard = NSPasteboard.general
    private var lastChangeCount: Int
    private var timer: Timer?
    
    private var lastSeen: String?
    var lastProgrammaticCopy: String?
    
    var onNewCopy: ((String) -> Void)?
    
    init() {
        lastChangeCount = pasteboard.changeCount
    }
    
    func copy(_ string: String) {
        lastProgrammaticCopy = string
        pasteboard.clearContents()
        pasteboard.setString(string, forType: .string)
    }
    
    func start() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
            if let copied = self.pasteboard.string(forType: .string),
               copied != self.lastSeen,
               copied != self.lastProgrammaticCopy {
                self.lastSeen = copied
                self.onNewCopy?(copied)
            }
        }
    }
    
    func stop() {
        timer?.invalidate()
    }
}
