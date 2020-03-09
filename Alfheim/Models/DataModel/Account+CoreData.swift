//
//  Account+CoreData.swift
//  Alfheim
//
//  Created by alex.huo on 2020/3/6.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import Foundation
import CoreData

final class Account: NSManagedObject, Identifiable {
  class func fetchRequest() -> NSFetchRequest<Account> {
      return NSFetchRequest<Account>(entityName: "Account")
  }

  @NSManaged var id: UUID
  @NSManaged var name: String
  @NSManaged var introduction: String
  @NSManaged var group: String
  @NSManaged var currency: Int16
  @NSManaged var tag: String?
  @NSManaged var emoji: String?
}
