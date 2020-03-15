//
//  Persistences+Transaction.swift
//  Alfheim
//
//  Created by alex.huo on 2020/3/8.
//  Copyright © 2020 blessingsoft. All rights reserved.
//

import Foundation
import Combine
import CoreData

extension Persistences {
  struct Transaction {
    let context: NSManagedObjectContext

    typealias FetchRequestPublisher = Publishers.FetchRequest<Alfheim.Transaction>

    init(context: NSManagedObjectContext) {
      self.context = context
    }

    // MARK: - CURD

    /// Save if has changes, should use in context.perform(_:) block if you need to update results, if not, update notification won't be send to
    /// subscriber, NSFetchedResultsController for example.
    func save() throws {
      guard context.hasChanges else {
        return
      }
      try context.save()
    }

    /// Delete, without save.
    func delete(_ object: NSManagedObject) {
      context.delete(object)
    }

    func object(withID id: UUID) -> NSManagedObject? {
      let predicate = NSPredicate(format: "id == %@", id as CVarArg)
      guard let object = context.registeredObjects(with: predicate).first else {
        return nil
      }
      return object
    }

    func transaction(withID id: UUID) -> Alfheim.Transaction? {
      let predicate = NSPredicate(format: "id == %@", id as CVarArg)
      guard let object = context.registeredObjects(with: predicate).first as? Alfheim.Transaction else {
        return nil
      }
      return object
    }

    // MARK: - Publishes

    func fetchRequestPublisher(sortDescriptors: [NSSortDescriptor] = [NSSortDescriptor(key: "date", ascending: false)],
                               predicate: NSPredicate? = nil) -> FetchRequestPublisher {
      let fetchRequest = NSFetchRequest<Alfheim.Transaction>(entityName: "Transaction")
      fetchRequest.sortDescriptors = sortDescriptors
      fetchRequest.predicate = predicate
      return Publishers.FetchRequest(fetchRequest: fetchRequest, context: context)
    }

    func fetchAllPublisher() -> AnyPublisher<[Alfheim.Transaction], NSError> {
      fetchRequestPublisher()
        .eraseToAnyPublisher()
    }

    func fetchPublisher(with predicate: NSPredicate) -> AnyPublisher<[Alfheim.Transaction], NSError> {
      fetchRequestPublisher(predicate: predicate)
        .eraseToAnyPublisher()
    }

    func fetchPublisher(withName name: String) -> AnyPublisher<Alfheim.Transaction, NSError> {
      let predicate = NSPredicate(format: "name == %@", name)
      return fetchPublisher(with: predicate).compactMap { $0.first }
        .eraseToAnyPublisher()
    }

    func fetchPublisher(withID id: UUID) -> AnyPublisher<Alfheim.Transaction, NSError> {
      let predicate = NSPredicate(format: "id == %@", id as CVarArg)
      return fetchPublisher(with: predicate).compactMap { $0.first }
        .eraseToAnyPublisher()
    }

    func fetchPublisher(from start: Date, to end: Date = Date()) -> AnyPublisher<[Alfheim.Transaction], NSError> {
      let predicate = NSPredicate(format: "date >= %@ AND date <= %@", start as NSDate, end as NSDate)
      return fetchPublisher(with: predicate)
    }
  }
}
