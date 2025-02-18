//
//  PhotosModal.swift
//  Cards
//
//  Created by Curtis Fisher on 2/15/25.
//


import SwiftUI
import PhotosUI //  using tool to import photos

struct PhotosModal: View {
  @Binding var card: Card
  @State private var selectedItems: [PhotosPickerItem] = []

  var body: some View {
    PhotosPicker(
      selection: $selectedItems,
      matching: .images) {
        ToolbarButton(modal: .photoModal)
    }
    .onChange(of: selectedItems) { items in
      for item in items {
        item.loadTransferable(type: Data.self) { result in
          Task {
            switch result {
            case .success(let data):
              if let data,
                let uiImage = UIImage(data: data) {
                card.addElement(uiImage: uiImage)
              }
            case .failure(let failure):
              fatalError("Image transfer failed: \(failure)")
            }
          }//  Creates an array to hold selected images, the Photos Picker Item doesnt contain the actual image, instead it contains only an identifier and the type of the content
            // next it displays the Photos Picker View and the user taps and selects the media assets, the photos picker adds them to the selectedItems 
        }// the modifier .onchange handles whenever the selectedItems state variable changes and print each element in the array after each item is processed
      }// in the for loop the item.load transferable loads the item as a data type, when succesfull it contains the image and failure contains a failure value.
      selectedItems = []
    }
  }
}

struct PhotosModal_Previews: PreviewProvider {
  static var previews: some View {
    PhotosModal(card: .constant(Card()))
  }
}
