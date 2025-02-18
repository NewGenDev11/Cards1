//
//  ElementContextMenu.swift
//  Cards
//
//  Created by Curtis Fisher on 2/16/25.
//

import Foundation

import SwiftUI
struct ElementContextMenu: ViewModifier {
    @Binding var card: Card
    @Binding var element: CardElement
    func body(content: Content) -> some View {
        content
            .contextMenu {
            Button {
            if let element = element as? TextElement {
            UIPasteboard.general.string = element.text
            } else if let element = element as? ImageElement,
            let image = element.uiImage {
            UIPasteboard.general.image = image
            }
            } label: {
            Label("Copy", systemImage: "doc.on.doc")
            }
                Button(role: .destructive) {
                    card.remove(element)
                } label: {
                    Label("Delete", systemImage: "trash")
                }
            }
    }
    

}// the Context Menu class uses access from the current card and current elemement creating a view modifier and pop up when long pressed are performed on a card element to copy or delete 
extension View {
    func elementContextMenu(
        card: Binding<Card>,
        element: Binding<CardElement>
    ) -> some View {
        modifier(ElementContextMenu(
            card: card,
            element: element))
    }
}// this extention calls the new modifer with a card and a an element value
