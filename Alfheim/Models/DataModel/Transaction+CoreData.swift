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
