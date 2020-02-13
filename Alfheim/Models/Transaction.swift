//
//  Transaction.swift
//  Alfheim
//
//  Created by bl4ckra1sond3tre on 2020/2/3.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import Foundation

struct Transaction {
  var date: Date
  var amount: Double
  var emoji: String
  var notes: String
  var currency: Currency = .cny
  var payee: String? = nil
  var number: Int = 0
  var from: Account? = Accounts.income
  var to: Account? = Accounts.expenses
}

enum Currency: Int {
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
