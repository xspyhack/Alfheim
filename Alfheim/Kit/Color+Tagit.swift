//
//  Color+Tagit.swift
//  Alfheim
//
//  Created by alex.huo on 2020/2/29.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import SwiftUI

extension Color {
  init(hex: Int, alpha: Double = 1) {
    let red = Double((hex & 0xFF0000) >> 16) / 255.0
    let green = Double((hex & 0xFF00) >> 8) / 255.0
    let blue = Double((hex & 0xFF) >> 0) / 255.0
    self.init(.sRGB, red: red, green: green, blue: blue, opacity: alpha)
  }
}

extension Color {
  init(tagit: Alne.Tagit) {
    self.init(hex: tagit.hexValue)
  }

  init(_ tag: Alne.Tagit) {
    self.init(hex: tag.hexValue)
  }
}
