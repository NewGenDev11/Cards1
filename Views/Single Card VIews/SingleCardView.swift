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

  var body: some View {
    NavigationStack {
      GeometryReader { proxy in
        CardDetailView(
          card: $card,
          viewScale: Settings.calculateScale(proxy.size),
          proxy: proxy)
          .frame(
            width: Settings.calculateSize(proxy.size).width,
            height: Settings.calculateSize(proxy.size).height)
          .clipped()
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .modifier(CardToolbar(
            currentModal: $currentModal,
            card: $card))
          .onDisappear {
            let uiImage = UIImage.screenshot(
              card: card,
              size: Settings.cardSize * 0.2)
            _ = uiImage.save(to: card.id.uuidString)
            card.uiImage = uiImage
            card.save()
          }// when done is pressed the save method runs through its function and saves the Card
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
