//
//  CardToolbar.swift
//  Cards
//
//  Created by Curtis Fisher on 2/15/25.
//



import SwiftUI

struct CardToolbar: ViewModifier {
  @EnvironmentObject var store: CardStore
  @Environment(\.dismiss) var dismiss
  @Binding var currentModal: ToolbarSelection?
  @Binding var card: Card
  @State private var stickerImage: UIImage?
  @State private var frameIndex: Int?
  @State private var textElement = TextElement()

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
        ToolbarItem(placement: .navigationBarLeading) {
          let uiImage = UIImage.screenshot(
            card: card,
            size: Settings.cardSize)
          let image = Image(uiImage: uiImage)
          ShareLink(
            item: image,
            preview: SharePreview(
              "Card",
              image: image)) {
                Image(systemName: "square.and.arrow.up")
          }
        }
        ToolbarItem(placement: .bottomBar) {
          BottomToolbar(
            modal: $currentModal, card: $card)
        }
      }// the modifier presents a sheet model overlay when the currentModal variable is not nil/empty, the currentModal variable will trigger the sheet to appear or dissapear
      // the switch statement checks the value of the currentModal which incorporates an Enum for case control, each case is binded to the view of the model for example case frameModal ties to the view of the frame model and such for each case 
      .sheet(item: $currentModal) { item in
        switch item {
        case .frameModal:
          FrameModal(frameIndex: $frameIndex)
            .onDisappear {
              if let frameIndex {
                card.update(
                  store.selectedElement,
                  frameIndex: frameIndex)
              }
              frameIndex = nil
            }
        case .stickerModal:
          StickerModal(stickerImage: $stickerImage)
            .onDisappear {
              if let stickerImage = stickerImage {
                card.addElement(uiImage: stickerImage)
              }
              stickerImage = nil
            }
        case .textModal:
          TextModal(textElement: $textElement)
            .onDisappear {
              if !textElement.text.isEmpty {
                card.addElement(text: textElement)
              }
              textElement = TextElement()
            }
        default:
          Text(String(describing: item))
        }
      }
  }

  var menu: some View {
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
      .disabled(!UIPasteboard.general.hasImages
        && !UIPasteboard.general.hasStrings)
    } label: {
      Label("Add", systemImage: "ellipsis.circle")
    }
  }
}// block of code handles copying and pasting images ffrom the werb browser to the app if the clipboard contains an image then it is shared to the pasteboard.
