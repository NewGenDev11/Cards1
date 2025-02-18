//
//  SingleCardView.swift
//  Cards
//
//  Created by Curtis Fisher on 2/15/25.
//


import SwiftUI

struct SingleCardView: View {
    @Binding var card: Card
    @State private var currentModal: ToolbarSelection?
    @State private var stickerImage: UIImage?
    
    var body: some View {
        NavigationStack {
            CardDetailView(card: $card)
                .modifier(CardToolbar(
                    currentModal: $currentModal,
                    card: $card))
                .onChange(of: stickerImage) { newValue in // When a sticker is selected
                    if let sticker = newValue {
                        card.addElement(uiImage: sticker) // Add to the card
                        stickerImage = nil // Reset for the next selection
                    }
                }
        }
    }
}

struct SingleCardView_Previews: PreviewProvider {
  struct SingleCardPreview: View {
    @EnvironmentObject var store: CardStore
    var body: some View {
      SingleCardView(card: $store.cards[0])
    }
  }
  static var previews: some View {
    SingleCardPreview()
      .environmentObject(CardStore(defaultData: true))
  }
}
