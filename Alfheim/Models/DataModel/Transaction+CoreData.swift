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
  @NSManaged var category: String?
  @NSManaged var emoji: String?
  @NSManaged var payee: String?
  @NSManaged var number: Int16
  @NSManaged var payment: Alfheim.Payment?
}

extension Transaction {
  /// Just like Equatable `==` method
  static func duplicated(lhs: Transaction, rhs: Transaction) -> Bool {
    guard lhs.id == rhs.id,
      lhs.date == rhs.date,
      lhs.amount == rhs.amount,
      lhs.notes == rhs.notes,
      lhs.currency == rhs.currency,
      lhs.category == rhs.category,
      lhs.emoji == rhs.emoji,
      Payment.duplicated(lhs: lhs.payment, rhs: rhs.payment),
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

extension Transaction {
  class Snapshot {
    let transaction: Transaction?

    var id: UUID
    var date: Date
    var amount: Double
    var category: String
    var emoji: String
    var notes: String
    var currency: Int16
    var payment: Alfheim.Payment?
    var payee: String? = nil
    var number: Int16 = 0

    init(_ transaction: Transaction) {
      self.transaction = transaction
      self.id = transaction.id
      self.date = transaction.date
      self.amount = transaction.amount
      self.category = transaction.category ?? ""
      self.emoji = transaction.emoji ?? ""
      self.notes = transaction.notes
      self.currency = transaction.currency
      self.payment = transaction.payment
    }

    init(date: Date,
         amount: Double,
         currency: Int16,
         category: String,
         emoji: String,
         notes: String,
         payment: Alfheim.Payment?) {
      self.transaction = nil
      self.id = UUID()
      self.date = date
      self.amount = amount
      self.category = category
      self.emoji = emoji
      self.notes = notes
      self.currency = currency
      self.payment = payment
    }
  }
  
}

extension Alfheim.Transaction {
  static func object(_ snapshot: Snapshot, context: NSManagedObjectContext) -> Alfheim.Transaction {
    let object = snapshot.transaction ?? Alfheim.Transaction(context: context)
    object.fill(snapshot)
    return object
  }

  func fill(_ snapshot: Snapshot) {
    id = snapshot.id
    amount = snapshot.amount
    currency = snapshot.currency
    date = snapshot.date
    notes = snapshot.notes
    category = snapshot.category
    emoji = snapshot.emoji
    payment = snapshot.payment
    payee = snapshot.payee
    number = snapshot.number
  }
}

