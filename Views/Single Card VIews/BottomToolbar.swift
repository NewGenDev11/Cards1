//
//  BottomToolbar.swift
//  Cards
//
//  Created by Curtis Fisher on 2/15/25.
//


import SwiftUI

struct ToolbarButton: View {
  let modal: ToolbarSelection
  private let modalButton: [
    ToolbarSelection: (text: String, imageName: String)
  ] = [
    .photoModal: ("Photos", "photo"),
    .frameModal: ("Frames", "square.on.circle"),
    .stickerModal: ("Stickers", "heart.circle"),
    .textModal: ("Text", "textformat")
  ]

  var body: some View {
    if let text = modalButton[modal]?.text,
      let imageName = modalButton[modal]?.imageName {
      VStack {
        Image(systemName: imageName)
          .font(.largeTitle)
        Text(text)
      }
      .padding(.top)
    }
  }
}

struct BottomToolbar: View {
  @Binding var modal: ToolbarSelection?
    @Binding var card: Card
    @EnvironmentObject var store: CardStore



    var body: some View {
        HStack(alignment: .bottom) {
            ForEach(ToolbarSelection.allCases) { selection in
                switch selection {
                case .photoModal:
                    Button {
                    } label: {
                        PhotosModal(card: $card)
                    }
                case .frameModal:
                    defaultButton(selection)
                        .disabled(
                            store.selectedElement == nil
                            || !(store.selectedElement is ImageElement))
                default:
                    defaultButton(selection)
                }
            }
        }// serperating out framemodel from the default button allows for the button to be disabled until an image is selected 

    }
    private func defaultButton(_ selection: ToolbarSelection) -> Button<ToolbarButton> {
        return Button {
            modal = selection
        } label: {
            ToolbarButton(modal: selection)
        }
    }
}//

struct BottomToolbar_Previews: PreviewProvider {
    static var previews: some View {
        BottomToolbar(
            modal: .constant(.stickerModal), card: .constant(Card()))
        .environmentObject(CardStore())
    }
}
