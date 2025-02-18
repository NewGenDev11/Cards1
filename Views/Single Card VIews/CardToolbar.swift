//
//  CardToolbar.swift
//  Cards
//
//  Created by Curtis Fisher on 2/15/25.
//



import SwiftUI

struct CardToolbar: ViewModifier {
    @Environment(\.dismiss) var dismiss
    @Binding var currentModal: ToolbarSelection?
    @Binding var card: Card
    @State private var stickerImage: UIImage?
    
    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                menu
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .bottomBar) {
                    BottomToolbar(
                        modal: $currentModal, card: $card)
                }
            }
            .sheet(item: $currentModal) { item in
                switch item {
                case .stickerModal:
                    StickerModal(stickerImage: $stickerImage)
                        .onDisappear {
                            if let stickerImage = stickerImage {
                                card.addElement(uiImage: stickerImage)
                            }
                            stickerImage = nil
                        }
                    
                    
                default:
                    Text(String(describing: item))
                }
            }
    }
    var menu: some View {
        // 1
        Menu {
            Button {
                if UIPasteboard.general.hasImages {
                    if let images = UIPasteboard.general.images {
                        for image in images {
                            card.addElement(uiImage: image)
                        }
                    }
                } else if UIPasteboard.general.hasStrings {
                    if let strings = UIPasteboard.general.strings {
                        for text in strings {
                            card.addElement(text: TextElement(text: text))
                        }
                    }
                }
            } label: {
                Label("Paste", systemImage: "doc.on.clipboard")
            }
            // 2
            .disabled(!UIPasteboard.general.hasImages
                      && !UIPasteboard.general.hasStrings)
        } label: {
            Label("Add", systemImage: "ellipsis.circle")
        }
    }
}
