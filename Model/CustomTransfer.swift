//
//  CustomTransfer.swift
//  Cards
//
//  Created by Curtis Fisher on 2/16/25.
//

import Foundation

import SwiftUI
struct CustomTransfer: Transferable {
    var image: UIImage?
    var text: String?
    public static var transferRepresentation: some
    TransferRepresentation {
        DataRepresentation(importedContentType: .image) { data in
            let image = UIImage(data: data)
            ?? UIImage(named: "error-image")
            return CustomTransfer(image: image)
        }
        DataRepresentation(importedContentType: .text) { data in
            let text = String(decoding: data, as: UTF8.self)
            return CustomTransfer(text: text)
        }
    }
}// this class contains two properites one for text and one for images, the transfer
// representation takes into account the image type and the text type and fills in the relevant property 
