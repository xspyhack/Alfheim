//
//  TransactionViewModel.swift
//  Alfheim
//
//  Created by alex.huo on 2020/3/14.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import Foundation
import CoreData

extension Alne.Transaction {
  init(_ object: Alfheim.Transaction) {
    self.id = object.id.uuidString
    self.date = object.date
    self.amount = object.amount
    self.catemoji = Catemoji(object.emoji!)
    self.notes = object.notes
    self.currency = Currency(rawValue: Int(object.currency))!
    self.payment = object.payment
    self.payee = object.payee
    self.number = Int(object.number)
  }
}

extension Alfheim.Transaction {
  static func object(_ model: Alne.Transaction, context: NSManagedObjectContext) -> Alfheim.Transaction {
    let object = Alfheim.Transaction(context: context)
    object.fill(model)
    return object
  }

  func fill(_ model: Alne.Transaction) {
    id = UUID(uuidString: model.id)!
    amount = model.amount
    currency = Int16(model.currency.rawValue)
    date = model.date
    notes = model.notes
    category = model.catemoji.category
    emoji = model.catemoji.emoji
    payment = model.payment
    payee = model.payee
    number = Int16(model.number)
  }
}
