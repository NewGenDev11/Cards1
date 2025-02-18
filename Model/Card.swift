//
//  Card.swift
//  Cards
//
//  Created by Curtis Fisher on 2/15/25.
//


import SwiftUI

struct Card: Identifiable {
  var id = UUID()
  var backgroundColor: Color = .yellow
  var elements: [CardElement] = []
  var uiImage: UIImage?

  mutating func addElement(uiImage: UIImage, at offset: CGSize = .zero) {
    let imageFilename = uiImage.save()
    let transform = Transform(offset: offset)
    let element = ImageElement(
      transform: transform,
      uiImage: uiImage,
      imageFilename: imageFilename)
    elements.append(element)
    save()
  }// adds elements to the uiImage

  mutating func addElement(text: TextElement) {
    elements.append(text)
  }// adds to the Text Element

  mutating func addElements(from transfer: [CustomTransfer], at offset: CGSize) {
    for element in transfer {
      if let text = element.text {
        addElement(text: TextElement(text: text))
      } else if let image = element.image {
        addElement(uiImage: image, at: offset)
      }
    }// uses the CustomTansfer structure to add ELEMENTS
  }

  mutating func remove(_ element: CardElement) {
    if let element = element as? ImageElement {
      UIImage.remove(name: element.imageFilename)
    }
    if let index = element.index(in: elements) {
      elements.remove(at: index)
    }
    save()
  }// Removes form the Card Element

  mutating func update(_ element: CardElement?, frameIndex: Int) {
    if let element = element as? ImageElement,
      let index = element.index(in: elements) {
        var newElement = element
        newElement.frameIndex = frameIndex
        elements[index] = newElement
    }
  }// updates the Card Element and the frame Index, the element is Immutable and nees to be updated its framework and creates a new mutabe copy and updates the elements with the new instance 

  func save() {
    do {
      let encoder = JSONEncoder()
      encoder.outputFormatting = .prettyPrinted
      let data = try encoder.encode(self)
      let filename = "\(id).rwcard"
      let url = URL.documentsDirectory
        .appendingPathComponent(filename)
      try data.write(to: url)
    } catch {
      print(error.localizedDescription)
    }
  }
}// saves the data to the apps doccument directory 

extension Card: Codable {
  enum CodingKeys: CodingKey {
    case id, backgroundColor, imageElements, textElements
  }

  init(from decoder: Decoder) throws {
    let container = try decoder
      .container(keyedBy: CodingKeys.self)
    let id = try container.decode(String.self, forKey: .id)
    self.id = UUID(uuidString: id) ?? UUID()
    elements += try container.decode(
      [ImageElement].self, forKey: .imageElements)
    elements += try container.decode([TextElement].self, forKey: .textElements)
    let components = try container.decode([CGFloat].self, forKey: .backgroundColor)
    backgroundColor = Color.color(components: components)
  }

  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(id.uuidString, forKey: .id)
    let imageElements: [ImageElement] =
      elements.compactMap { $0 as? ImageElement }
    try container.encode(imageElements, forKey: .imageElements)
    let textElements: [TextElement] =
      elements.compactMap { $0 as? TextElement }
    try container.encode(textElements, forKey: .textElements)
    let components = backgroundColor.colorComponents()
    try container.encode(components, forKey: .backgroundColor)
  }
}// enables the Card struct to be encoded into a data representation of JSON and decoded back from that representation for allowing saving and loading.
    // the Decoder initializer decodes the Card Object and retrieves its data properties
//  the Encoder initializer handles encoding the Card Object into a data representation
