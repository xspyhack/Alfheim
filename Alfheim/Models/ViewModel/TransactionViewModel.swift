//
//  TransactionViewModel.swift
//  Alfheim
//
//  Created by alex.huo on 2020/3/14.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import Foundation
import CoreData

struct TransactionViewModel: Identifiable {
  let transaction: Alfheim.Transaction

  let tag: Alne.Tagit

  let id: String
  let date: Date
  let amount: Double
  let catemoji: Catemojis
  let notes: String
  let currency: Currency
  /// payment method
  let payment: Alne.Payment
  let payee: String? = nil
  let number: Int = 0
}

extension TransactionViewModel {
  init(transaction: Alfheim.Transaction, tag: Alne.Tagit) {
    self.transaction = transaction
    self.id = transaction.id.uuidString
    self.date = transaction.date
    self.amount = transaction.amount
    self.catemoji = transaction.emoji.map { Catemojis($0) } ?? .uncleared(.uncleared)
    self.notes = transaction.notes
    self.currency = Currency(rawValue: Int(transaction.currency)) ?? .cny
    self.payment = transaction.payment.map { Alne.Payment($0) } ?? Payments.uncleared
    self.tag = tag
  }
}

#if DEBUG
extension TransactionViewModel {
  static var mock: TransactionViewModel {
    let transaction = Alfheim.Transaction()
    transaction.id = UUID()
    transaction.date = Date(timeIntervalSince1970: 1582726132.0)
    transaction.amount = 23.0
    transaction.category = "Fruit"
    transaction.emoji = Catemojis.Fruit.apple.emoji
    transaction.notes = "Apple"
    transaction.currency = Int16(Currency.cny.rawValue)
    return TransactionViewModel(transaction: transaction, tag: .alfheim)
  }
}
#endif
