//
//  ToolbarSelection.swift
//  Cards
//
//  Created by Curtis Fisher on 2/15/25.
//


import Foundation

enum ToolbarSelection: CaseIterable, Identifiable {
  var id: Int {
    hashValue
  }

  case photoModal, frameModal, stickerModal, textModal
}
