//
//  Transaction+CoreData.swift
//  Alfheim
//
//  Created by alex.huo on 2020/3/6.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import Foundation
import CoreData

final class Transaction: NSManagedObject, Identifiable {
  class func fetchRequest() -> NSFetchRequest<Transaction> {
      return NSFetchRequest<Transaction>(entityName: "Transaction")
  }

  @NSManaged var id: UUID
  @NSManaged var date: Date
  @NSManaged var amount: Double
  @NSManaged var notes: String
  @NSManaged var currency: Int16
  @NSManaged var emoji: String?
  @NSManaged var payment: String?
  @NSManaged var payee: String?
  @NSManaged var number: Int16
}

extension Transaction {
  /// Just like Equatable `==` method
  static func duplicated(lhs: Transaction, rhs: Transaction) -> Bool {
    guard lhs.id == rhs.id,
      lhs.date == rhs.date,
      lhs.amount == rhs.amount,
      lhs.notes == rhs.notes,
      lhs.currency == rhs.currency,
      lhs.emoji == rhs.emoji,
      lhs.payment == rhs.payment,
      lhs.payee == rhs.payee,
      lhs.number == rhs.number else {
      return false
    }
    return true
  }
}


extension Array where Element: Alfheim.Transaction {
  static func duplicated(lhs: Self, rhs: Self) -> Bool {
    guard lhs.count == rhs.count else {
      return false
    }

    for (l, r) in zip(lhs, rhs) {
      if !Transaction.duplicated(lhs: l, rhs: r) {
        return false
      }
    }
    return true
  }
}
