//
//  AppState+Editor.swift
//  Alfheim
//
//  Created by bl4ckra1sond3tre on 2020/3/7.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import Foundation
import Combine
import CoreData

extension AppState {
  /// Composer, editor state
  struct Editor: Equatable {
    enum Mode: Equatable {
      case new
      case edit(Transaction)

      var isNew: Bool {
        switch self {
        case .new:
          return true
        default:
          return false
        }
      }
    }

    var mode: Mode = .new
    var amount: String = ""
    var currency: Currency = .cny
    var catemoji: Alne.Catemoji = Alne.Catemoji(category: .uncleared, emoji: Alne.Uncleared.uncleared.emoji)
    var date: Date = Date()
    var notes: String = ""
    var payment: Int = 0

    var isValid: Bool = false

    var isNew: Bool {
      return mode.isNew
    }

    var payments: [Alfheim.Payment] = []
    var catemojis: [Category: [Alne.Catemoji]] = [:]
  }
}

extension AppState.Editor {
  mutating func reset(_ mode: Mode) {
    switch mode {
    case .new:
      amount = ""
      currency = .cny
      catemoji = Alne.Catemoji(category: .uncleared, emoji: Alne.Uncleared.uncleared.emoji)
      date = Date()
      notes = ""
      payment = 0
    case .edit(let transaction):
      amount = "\(transaction.amount)"
      currency = Currency(rawValue: Int(transaction.currency)) ?? .cny
      if let value = transaction.category, let category = Category(rawValue: value), let emoji = transaction.emoji {
        catemoji = Alne.Catemoji(category: category, emoji: emoji)
      } else {
        catemoji = Alne.Catemoji.uncleared
      }
      date = transaction.date
      notes = transaction.notes
      if let payment = transaction.payment,
        let index = payments.firstIndex(of: payment) {
        self.payment = index
      } else {
        payment = 0
      }
    }
    self.mode = mode
  }
}

extension AppState.Editor {
  var transaction: Alfheim.Transaction.Snapshot {
    let pm = payments.count > payment ? payments[payment] : nil
    let snapshot: Alfheim.Transaction.Snapshot
    switch mode {
    case .new:
      snapshot = Alfheim.Transaction.Snapshot(date: date,
                                              amount: Double(amount)!,
                                              currency: Int16(currency.rawValue),
                                              category: catemoji.category.rawValue,
                                              emoji: catemoji.emoji,
                                              notes: notes,
                                              payment: pm)
    case .edit(let transaction):
      transaction.date = date
      transaction.amount = Double(amount)!
      transaction.category = catemoji.category.rawValue
      transaction.emoji = catemoji.emoji
      transaction.notes = notes
      transaction.currency = Int16(currency.rawValue)
      transaction.payment = pm
      snapshot = Alfheim.Transaction.Snapshot(transaction)        }
    return snapshot
  }
}

extension String {
  var isValidAmount: Bool {
    self != "" && Double(self) != nil
  }
}
