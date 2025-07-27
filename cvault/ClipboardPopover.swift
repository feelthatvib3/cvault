//
//  ClipboardPopover.swift
//  cvault
//
//  Created by feelthatvib3 on 7/27/25.
//

import SwiftUI

struct ClipboardPopover: View {
    @ObservedObject var store: ClipboardStore

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Clipboard History")
                .font(.headline)
                .padding(.bottom, 4)

            if store.items.isEmpty {
                Spacer()
                HStack {
                    Spacer()
                    Text("Nothing copied yet.")
                        .foregroundColor(.secondary)
                    Spacer()
                }
                Spacer()
            } else {
                ScrollView(.vertical) {
                    LazyVStack(alignment: .leading, spacing: 8) {
                        ForEach(store.items.indices, id: \.self) { index in
                            let item = store.items[index]
                            Button(action: {
                                NSPasteboard.general.clearContents()
                                NSPasteboard.general.setString(item, forType: .string)
                            }) {
                                Text(item)
                                    .font(.system(size: 13, weight: .regular, design: .monospaced))
                                    .foregroundColor(.primary)
                                    .padding(6)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .background(
                                        RoundedRectangle(cornerRadius: 6)
                                            .fill(Color.gray.opacity(0.12))
                                    )
                            }
                            .buttonStyle(PlainButtonStyle())
                            .contextMenu {
                                Button("Copy") {
                                    NSPasteboard.general.clearContents()
                                    NSPasteboard.general.setString(item, forType: .string)
                                }
                            }
                        }
                    }
                }

            }
        }
        .padding(16)
        .frame(width: 300, height: 350)
    }
}
