//
//  Attachment.swift
//  Alfheim
//
//  Created by alex.huo on 2021/1/31.
//  Copyright © 2021 blessingsoft. All rights reserved.
//

import CoreData

final class Attachment: NSManagedObject, Identifiable {
  @nonobjc public class func fetchRequest() -> NSFetchRequest<Attachment> {
      return NSFetchRequest<Attachment>(entityName: "Attachment")
  }

  @NSManaged var id: UUID
  @NSManaged var thumbnail: NSObject?
  @NSManaged var url: String?
  // relationship
  @NSManaged var transaction: Transaction?
}

extension Attachment: Duplicatable {
  // Just like Equatable `==` method
  static func duplicated(lhs: Attachment, rhs: Attachment) -> Bool {
    guard lhs.id == rhs.id,
          lhs.thumbnail == rhs.thumbnail,
          lhs.url == rhs.url,
          lhs.transaction == rhs.transaction
    else {
      return false
    }
    return true
  }
}
