//
//  Transform.swift
//  Cards
//
//  Created by Curtis Fisher on 2/15/25.
//


import SwiftUI

struct Transform {
  var size = CGSize(
    width: Settings.defaultElementSize.width,
    height: Settings.defaultElementSize.height)
  var rotation: Angle = .zero
  var offset: CGSize = .zero
}

extension Transform: Codable {}
