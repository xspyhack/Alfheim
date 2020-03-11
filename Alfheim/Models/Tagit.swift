//
//  Tagit.swift
//  Alfheim
//
//  Created by alex.huo on 2020/2/29.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import Foundation

extension Alne {
  enum Tagit: String, CaseIterable {
    case red
    case orange
    case yellow
    case green
    case blue
    case purple
    case alfheim = "tint"

    var name: String {
      return rawValue.capitalized
    }
  }
}

extension Tagit: Identifiable {
  var id: String {
    return rawValue
  }
}

extension Tagit {
  init(hex: Int) {
    self.init(stringLiteral: String(format:"#%06X", hex))
  }

  var hexValue: Int {
    Int(hex.dropFirst(), radix: 16)!
  }
}

extension Tagit {
  var hex: String {
    switch self {
    case .red:
      return "#f03e3e"
    case .orange:
      return "#f76707"
    case .yellow:
      return "#f59f00"
    case .green:
      return "#37b24d"
    case .blue:
      return "#1c7ed6"
    case .purple:
      return "#7048e8"
    case .alfheim:
      return "#d6336c"
    }
  }
}

extension Tagit: ExpressibleByIntegerLiteral {
  init(integerLiteral value: Int) {
    switch value {
    case 0:
      self = .red
    case 1:
      self = .orange
    case 2:
      self = .yellow
    case 3:
      self = .green
    case 4:
      self = .blue
    case 5:
      self = .purple
    default:
      self = .alfheim
    }
  }
}

extension Tagit: ExpressibleByStringLiteral {
  init(stringLiteral value: String) {
    switch value {
    case "#f03e3e":
      self = .red
    case "#f76707":
      self = .orange
    case "#f59f00":
      self = .yellow
    case "#37b24d":
      self = .green
    case "#1c7ed6":
      self = .blue
    case "#7048e8":
      self = .purple
    default:
      self = .alfheim
    }
  }
}
