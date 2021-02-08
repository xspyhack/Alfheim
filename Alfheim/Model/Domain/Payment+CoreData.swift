//
//  Payment+CoreData.swift
//  Alfheim
//
//  Created by alex.huo on 2020/3/25.
//  Copyright © 2020 blessingsoft. All rights reserved.
//
//

import Foundation
import CoreData

// duprecated
final class Payment: NSManagedObject, Identifiable {
  @nonobjc public class func fetchRequest() -> NSFetchRequest<Payment> {
      return NSFetchRequest<Payment>(entityName: "Payment")
  }

  @NSManaged var id: UUID
  @NSManaged var name: String
  @NSManaged var introduction: String? // description
  @NSManaged var kind: Int16
  @NSManaged var transactions: NSSet?
}

extension Payment {
  // Just like Equatable `==` method
  static func duplicated(lhs: Payment, rhs: Payment) -> Bool {
    guard lhs.id == rhs.id,
      lhs.name == rhs.name,
      lhs.kind == rhs.kind,
      lhs.introduction == rhs.introduction,
      lhs.transactions == rhs.transactions else {
      return false
    }
    return true
  }

  static func duplicated(lhs: Payment?, rhs: Payment?) -> Bool {
    guard let lhs = lhs, let rhs = rhs,
      lhs.id == rhs.id,
      lhs.name == rhs.name,
      lhs.kind == rhs.kind,
      lhs.introduction == rhs.introduction,
      lhs.transactions == rhs.transactions else {
      return false
    }
    return true
  }
}

extension Payment {
  class Snapshot {
    let payment: Payment?

    var id: UUID
    var name: String
    var introduction: String?
    var kind: Int16
    var transactions: NSSet?

    // for new payment
    init(name: String,
         description: String?,
         kind: Int16) {
      self.payment = nil
      self.id = UUID()
      self.name = name
      self.introduction = description
      self.kind = kind
      self.transactions = nil
    }

    // for edit payment
    init(_ payment: Payment) {
      self.payment = payment
      self.id = payment.id
      self.name = payment.name
      self.introduction = payment.introduction
      self.kind = payment.kind
      self.transactions = payment.transactions
    }
  }
}

extension Alfheim.Payment {
  static func object(_ snapshot: Snapshot, context: NSManagedObjectContext) -> Alfheim.Payment {
    let object = snapshot.payment ?? Alfheim.Payment(context: context)
    object.fill(snapshot)
    return object
  }

  func fill(_ snapshot: Snapshot) {
    id = snapshot.id
    name = snapshot.name
    introduction = snapshot.introduction
    kind = snapshot.kind
    transactions = snapshot.transactions
  }
}
