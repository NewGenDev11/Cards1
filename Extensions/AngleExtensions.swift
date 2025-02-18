//
//  AngleExtensions.swift
//  Cards
//
//  Created by Curtis Fisher on 2/16/25.
//

import Foundation
import SwiftUI

enum CodingKeys: CodingKey {
case degrees
}

extension Angle: Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let degrees = try container
        .decode(Double.self, forKey: .degrees)
        self.init(degrees: degrees)
    }
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(degrees, forKey: .degrees)
    }

    
}

