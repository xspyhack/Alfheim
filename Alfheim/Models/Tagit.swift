//
//  Tagit.swift
//  Alfheim
//
//  Created by alex.huo on 2020/2/29.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import Foundation

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
      return "#FF2600"
    case .orange:
      return "#FF9200"
    case .yellow:
      return "#FEFB00"
    case .green:
      return "#00F900"
    case .blue:
      return "#0432FF"
    case .purple:
      return "#932092"
    case .alfheim:
      return "#60D3D4"
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
    case "#FF2600":
      self = .red
    case "#FF9200":
      self = .orange
    case "#FEFB00":
      self = .yellow
    case "#00F900":
      self = .green
    case "#0432FF":
      self = .blue
    case "#932092":
      self = .purple
    default:
      self = .alfheim
    }
  }
}
