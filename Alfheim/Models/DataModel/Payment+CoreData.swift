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

final class Payment: NSManagedObject, Identifiable {
  @nonobjc public class func fetchRequest() -> NSFetchRequest<Payment> {
      return NSFetchRequest<Payment>(entityName: "Payment")
  }

  @NSManaged var id: UUID
  @NSManaged var name: String
  @NSManaged var kind: Int16
  @NSManaged var transactions: NSSet?
}

extension Payment {
  // Just like Equatable `==` method
  static func duplicated(lhs: Payment, rhs: Payment) -> Bool {
    guard lhs.id == rhs.id,
      lhs.name == rhs.name,
      lhs.kind == rhs.kind,
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
      lhs.transactions == rhs.transactions else {
      return false
    }
    return true
  }
}
