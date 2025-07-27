//
//  ClipboardStore.swift
//  cvault
//
//  Created by feelthatvib3 on 7/27/25.
//

import Foundation

class ClipboardStore: ObservableObject {
    @Published var items: [String] = []
    
    func add(_ item: String) {
        let trimmed = item.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        guard items.first != trimmed else { return }
        
        items.insert(trimmed, at: 0)
        if items.count > 50 {
            items = Array(items.prefix(50))
        }
    }
    
    func clear() {
        items.removeAll()
    }
}
