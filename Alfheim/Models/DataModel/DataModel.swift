//
//  DataModel.swift
//  Alfheim
//
//  Created by alex.huo on 2020/3/6.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import Foundation

enum DataModel {
}

extension DataModel {
  enum Currency: Int, CaseIterable {
    case cny
    case hkd
    case jpy
    case usd

    var text: String {
      switch self {
      case .cny: return "CNY"
      case .hkd: return "HKD"
      case .jpy: return "JPY"
      case .usd: return "USD"
      }
    }

    var symbol: String {
      switch self {
      case .cny: return "¥"
      case .hkd: return "$"
      case .jpy: return "¥"
      case .usd: return "$"
      }
    }
  }
}
